//
//  SMarkRenderer.swift
//  SMark
//
//  Created by LawLincoln on 16/8/23.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import SMark
import YAMLFrameworkOrdered
import Handlebars
//MARK:- Renderer
public final class Renderer {
    public typealias RenderingChange = (String) -> Void
    public var renderingChange: RenderingChange?
    public fileprivate(set) var documentTemplate = ""
    fileprivate var _title = ""
    fileprivate var _markdown = ""
    fileprivate let _nestingLevel: Int = 6
    fileprivate lazy var _languageMap: [String : AnyObject] = self.getLanguageMap()
    fileprivate lazy var _aliasMap: [String : String] = self.getAliasMap()
    fileprivate var _languages: [String] {
        get { return Configurator.shared.currentLanguages }
        set(val) { Configurator.shared.currentLanguages = val }
    }
    fileprivate lazy var _tocRegex: NSRegularExpression? = {
        let pattern = "<p.*?>\\s*\\[TOC\\]\\s*</p>"
        let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return reg
    }()
}
// MARK: - Lazy getter
extension Renderer {
    
    fileprivate func getAliasMap() -> [String: String] {
        guard let data = Resource.SyntaxHighlightingJson.fullPath.pathContent.data(using: String.Encoding.utf8) else { return [:] }
        do {
            guard let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : [String : String]], let map = obj["aliases"] else { return [:] }
            return map
        } catch { return [:] }
    }
    
    fileprivate func getLanguageMap() -> [String: AnyObject] {
        let raw = Resource.Prism.ComponentsJs.fullPath.pathContent.replacingOccurrences(of: "var components = ", with: "").replacingOccurrences(of: ";", with: "")
        guard let data = raw.data(using: String.Encoding.utf8) else { return [:] }
        do {
            guard let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else { return [:] }
            let lang = obj["languages"] as? [String : [String : AnyObject]]
            return lang as [String : AnyObject]? ?? [:]
        } catch { return [:] }
    }
}

public extension Renderer {
    
    func parserCurrentDocument() { _parse() }
    func renderCurrnetDocument() { _ = _doRender() }
    
    func render(markdown text: String, title: String = "", forExport: Bool = false, renderingChange monitor: RenderingChange? = nil) -> String {
        _markdown = text
        _title = title
        renderingChange = monitor
        if forExport { return export() }
        return _parseAndRender()
    }
    
    func export(styling enableStyleSheet: Bool = true, highlighting enableHighlight: Bool = true) -> String {
        _parse()
        var styleOption = Scripts.Option.none
        var scriptOption = Scripts.Option.none
        var styles: [Scripts.StyleSheet] = []
        var scripts: [Scripts.JavaScript] = []
        if enableStyleSheet {
            styleOption = .embedded
            styles.append(contentsOf: Scripts.baseStylesheets)
        }
        if enableHighlight {
            styleOption = .embedded
            scriptOption = .embedded
            styles.append(contentsOf: Scripts.prismStylesheets)
            scripts.append(contentsOf: Scripts.prismScripts)
        }
        if Configurator.shared.renderMathJax {
            scriptOption = .embedded
            scripts.append(contentsOf: Scripts.mathjaxScripts)
        }
        return _totalDocumentFor(scriptOption: scriptOption, styleOption: styleOption)
    }
}
extension Renderer {
    
    fileprivate func _parseAndRender() -> String {
        _parse()
        return _doRender()
    }
    
    fileprivate func _parse() {
        let configue = Configurator.shared
        configue.currentLanguages = []
        let flags = SMark.HTML.Tag.flags(from: configue.tags)
        let extensions = SMark.HTML.Extension.flags(from: configue.extensions)
        let hasSmartypants = configue.smartypantsEnable
        let hasFrontMatter = configue.frontMatterDecodeEnable
        let hasToc = configue.tocRenderEnable
        var markdown = _markdown
        var frontMatter: M13OrderedDictionary<NSString, AnyObject>? = nil
        if hasFrontMatter {
            let (obj, offset) = markdown.frontMatter
            frontMatter = obj
            markdown = markdown.substring(from: markdown.characters.index(markdown.startIndex, offsetBy: offset))
        }
        let owner = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        let htmlRender = smark_html_renderer(flags, Int32(_nestingLevel), { (language, owner) -> UnsafeMutablePointer<hoedown_buffer>? in
            let back = hoedown_buffer_new(64)
            
            let sself = Unmanaged<Renderer>.fromOpaque(owner!).takeUnretainedValue()
            if let lang = NSString(bytes: language!.pointee.data, length: language!.pointee.size, encoding: String.Encoding.utf8.rawValue) {
                var lang: String! = lang as String
                var backLang = lang
                if let alias = sself._aliasMap[lang] {
                    backLang = alias
                }
                if let data = backLang?.data(using: String.Encoding.utf8) {
                    hoedown_buffer_put(back, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count)
                }
                repeat {
                    if lang == nil { break }
                    if let index = sself._languages.index(of: lang) {
                        sself._languages.remove(at: index)
                    }
                    sself._languages.insert(lang, at: 0)
                    if let obj = sself._languageMap[lang] as? [String : AnyObject] {
                        lang = obj["require"] as? String
                    } else { lang = nil }
                } while(lang != nil)
            }
            return back!
            }, owner)
        var tocRenderer: UnsafeMutablePointer<hoedown_renderer>? = nil
        if hasToc {
            tocRenderer = smark_toc_renderer(owner, Int32(_nestingLevel))
        }
        documentTemplate = _toHTMLTemplate(from: markdown, extensions: extensions, smartypants: hasSmartypants, htmlRenderer: htmlRender!, tocRenderer: tocRenderer, frontMatter: frontMatter?.HTMLTable)
        if let t = tocRenderer { hoedown_html_renderer_free(t) }
        smark_free_renderer(htmlRender)
    }
    
    fileprivate func _doRender() -> String {
        let html = _totalDocumentFor(scriptOption: .fulllink, styleOption: .fulllink)
        renderingChange?(html)
        return html
    }
}
//MARK: Generate HTML from markdown
private extension Renderer {
    
    func _toHTMLTemplate(from markdown: String, extensions: hoedown_extensions, smartypants: Bool, htmlRenderer: UnsafePointer<hoedown_renderer>, tocRenderer: UnsafePointer<hoedown_renderer>? = nil, frontMatter: String? = nil) -> String {
        guard let data = (markdown as NSString).data(using: String.Encoding.utf8.rawValue) else { return "" }
        var result = _render(with: htmlRenderer, extensions: extensions, max: Int.max, data: data, smartypants: smartypants)
        
        if let toc = tocRenderer, let r = result, let t = _render(with: toc, extensions: extensions, max: _nestingLevel, data: data) {
            let mutalbeString = NSMutableString(string: r)
            _ = _tocRegex?.replaceMatches(in: mutalbeString, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, r.characters.count), withTemplate: t)
            result = mutalbeString as String
        }
        if let front = frontMatter, let r = result {
            result = "\(front)\n\(r)"
        }
        return result ?? ""
    }
    
    func _render(with renderer:UnsafePointer<hoedown_renderer>, extensions: hoedown_extensions, max level: Int, data: Data, smartypants: Bool? = nil ) -> String? {
        let document = hoedown_document_new(renderer, extensions, level)
        var ob = hoedown_buffer_new(64)
        hoedown_document_render(document, ob, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count)
        if smartypants == true {
            let ib = ob
            ob = hoedown_buffer_new(64)
            hoedown_html_smartypants(ob, ib?.pointee.data, (ib?.pointee.size)!)
            hoedown_buffer_free(ib)
        }
        let chars = UnsafePointer<CChar>(hoedown_buffer_cstr(ob))!
        let result = String(cString: chars, encoding: .utf8)
        hoedown_document_free(document)
        hoedown_buffer_free(ob)
        return result
    }
    
    func _totalDocumentFor(scriptOption: Scripts.Option, styleOption: Scripts.Option) -> String {
        let stylesheets = Scripts.stylesheets.flatMap({ $0.html(for: styleOption) })
        let scrits = Scripts.scripts.flatMap({ $0.html(for: scriptOption) })
        let template = Configurator.shared.htmlTemplateRaw
        assert(template.characters.count > 0, "Unable to load template")
        var titleTag = ""
        if _title.characters.count > 0 { titleTag = "<title>\(_title)</title>" }
        let context = [
           "title": _title,
           "titleTag": titleTag,
           "styleTags": stylesheets,
           "body": documentTemplate,
           "scriptTags": scrits,
        ] as [String : Any]
        let html = try? HBHandlebars.renderTemplateString(template, withContext: context)
        return html ?? ""
    }
}
