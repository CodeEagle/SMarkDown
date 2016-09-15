//
//  SMarkConfigurator.swift
//  SMark
//
//  Created by LawLincoln on 16/8/23.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import SMark

let UserDefault = UserDefaults.standard

public extension String {
    
    func htmlWith(title: String, forExport: Bool = false, renderingChange monitor: Renderer.RenderingChange? = nil) -> String {
        return Configurator.shared.renderer.render(markdown: self, title: title, forExport: forExport, renderingChange: monitor)
    }
}
public final class Configurator {
    
    fileprivate enum Keys: String { case tags = "tags", extensions = "extensions", codeBlockAccessory = "codeBlockAccessory", tocRenderEnable = "tocRenderEnable", htmlTemplate = "htmlTemplate", htmlStyle = "htmlStyle", htmlHighlightingTheme = "htmlHighlightingTheme", htmlSyntaxHighlighting = "htmlSyntaxHighlighting", smartypantsEnable = "smartypantsEnable", frontMatterDecodeEnable = "frontMatterDecodeEnable", storeKey = "SMarkConfigurator"
    }
    fileprivate var initing = false
    public var tags: [SMark.HTML.Tag] = [] { didSet { parserRenderSave() } }
    public var extensions: [SMark.HTML.Extension] = [] { didSet { parseAndSave() } }
    public var codeBlockAccessory: SMark.CodeBlockAccessory = .none { didSet { renderAndSave() } }
    public var tocRenderEnable = false { didSet { parseAndSave() } }
    
    public var htmlStyle: Resource.Styles? = Resource.Styles.Github2Css { didSet { renderAndSave() } }
    public var htmlHighlightingTheme: Resource.Prism.Themes? = .PrismOkaidiaCss { didSet { renderAndSave() } }
    public var htmlSyntaxHighlighting: Bool = true { didSet { renderAndSave() } }
    public var smartypantsEnable = false { didSet { parseAndSave() } }
    public var frontMatterDecodeEnable = true { didSet { parseAndSave() } }
    
    public static var shared = Configurator()
    public var renderer = Renderer()
    var httpServerEnable = false
    public func enableHttpServer(wiht htmlRoot: String) {
        copyResource(to: htmlRoot)
        httpServerEnable = true
        
    }
    
    fileprivate func copyResource(to root: String) {
        let folder = "Resource"
        let bundle = Bundle(for: Configurator.self)
        guard let path = bundle.path(forResource: folder, ofType: nil) else { return }
        let target = (root as NSString).appendingPathComponent(folder)
        let fm = FileManager.default
        var isDir = ObjCBool(true)
        if !fm.fileExists(atPath: target, isDirectory: &isDir) {
            do {
                try fm.copyItem(atPath: path, toPath: target)
            } catch { }
        }
    }
    var currentLanguages = [String]()
    var htmlTemplate = Resource.Templates.DefaultHandlebars {
        didSet {
            htmlTemplateRaw = htmlTemplate.fullPath.pathContent
            parserRenderSave()
        }
    }
    lazy var htmlTemplateRaw: String = self.htmlTemplate.fullPath.pathContent
    
    fileprivate init() {
        initing = true
        loadUserConfigure()
        initing = false
    }
    
    fileprivate func parseAndSave() {
        if initing { return }
        storeConfigure()
        renderer.parserCurrentDocument()
    }
    fileprivate func renderAndSave() {
        if initing { return }
        storeConfigure()
        renderer.renderCurrnetDocument()
    }
    fileprivate func parserRenderSave() {
        if initing { return }
        storeConfigure()
        renderer.parserCurrentDocument()
        renderer.renderCurrnetDocument()
    }
}

extension Configurator {
    var showLineNumber: Bool { return tags.contains(.blockcodeLineNumber) }
    var showLanguageName: Bool { return codeBlockAccessory == .languageName  }
    var usingTaskList: Bool { return tags.contains(.useTaskList) }
    var renderMathJax: Bool { return extensions.contains(.math) }
}

private extension Configurator {
    
    func loadUserConfigure() {
        guard let value = UserDefault.object(forKey: Keys.storeKey.rawValue) as? [String: AnyObject] else { return }
        if let t = value[Keys.tags.rawValue] as? [NSNumber] {
            tags = t.flatMap({ SMark.HTML.Tag(rawValue: $0.uint32Value) })
        }
        if let e = value[Keys.extensions.rawValue] as? [NSNumber] {
            extensions = e.flatMap({ SMark.HTML.Extension(rawValue: $0.uint32Value) })
        }
        if let c = value[Keys.codeBlockAccessory.rawValue] as? Int, let v = SMark.CodeBlockAccessory(rawValue: c) {
            codeBlockAccessory = v
        }
        if let h = value[Keys.htmlStyle.rawValue] as? String, let v = Resource.Styles(rawValue: h) {
            htmlStyle = v
        }
        if let h = value[Keys.htmlTemplate.rawValue] as? String, let v = Resource.Templates(rawValue: h) {
            htmlTemplate = v
        }
        if let h = value[Keys.htmlHighlightingTheme.rawValue] as? String, let v = Resource.Prism.Themes(rawValue: h) {
            htmlHighlightingTheme = v
        }
        if let c = value[Keys.htmlSyntaxHighlighting.rawValue] as? Bool {
            htmlSyntaxHighlighting = c
        }
        if let c = value[Keys.smartypantsEnable.rawValue] as? Bool {
            smartypantsEnable = c
        }
        if let c = value[Keys.frontMatterDecodeEnable.rawValue] as? Bool {
            frontMatterDecodeEnable = c
        }
    }
    
    func storeConfigure() {
        let tagsValue = tags.flatMap({ NSNumber(value: $0.rawValue as UInt32) })
        let extensionsValue = extensions.flatMap({ NSNumber(value: $0.rawValue as UInt32) })
        var json: [String : AnyObject] = [
            Keys.tags.rawValue : tagsValue as AnyObject,
            Keys.extensions.rawValue : extensionsValue as AnyObject,
            Keys.codeBlockAccessory.rawValue : codeBlockAccessory.rawValue as AnyObject,
            Keys.tocRenderEnable.rawValue : tocRenderEnable as AnyObject,
            Keys.htmlTemplate.rawValue : htmlTemplate.rawValue as AnyObject,
            Keys.htmlSyntaxHighlighting.rawValue : htmlSyntaxHighlighting as AnyObject,
            Keys.smartypantsEnable.rawValue : smartypantsEnable as AnyObject,
            Keys.frontMatterDecodeEnable.rawValue : frontMatterDecodeEnable as AnyObject
        ]
        json[Keys.htmlStyle.rawValue] = htmlStyle?.rawValue as AnyObject?
        json[Keys.htmlHighlightingTheme.rawValue] = htmlHighlightingTheme?.rawValue as AnyObject?
        
        DispatchQueue.global(qos: .default).async {
            UserDefault.set(json, forKey: Keys.storeKey.rawValue)
            UserDefault.synchronize()
        }
    }
}

public struct SMark {
    
    public struct HTML {
        public enum Tag: UInt32 {
            case skipHTML, escape, hardWrap, useXHTML, useTaskList, blockcodeLineNumber, blockcodeInfomation
            static func flags(from tags: [Tag]) -> hoedown_html_flags {
                var raw: UInt32 = 0
                for tag in tags {  raw |=  1 << tag.rawValue }
                return hoedown_html_flags(raw)
            }
        }
        
        public enum Extension: UInt32 {
            case tables, fencedCode, footnotes, autolink, strikethrough, underline, highlight, quote, superscript, math, noIntraEmphasis = 11, spaceHeaders, mathExplicit, disableIndentedCode
            static func flags(from tags: [Extension]) -> hoedown_extensions {
                var raw: UInt32 = 0
                for tag in tags {  raw |= 1 << tag.rawValue }
                return hoedown_extensions(raw)
            }
        }
    }
    
    public enum CodeBlockAccessory: Int { case none, languageName, custom }
}



