//
//  SMarkConfigurator.swift
//  SMark
//
//  Created by LawLincoln on 16/8/23.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import SMark

let UserDefault = NSUserDefaults.standardUserDefaults()

public extension String {
    
    func htmlWith(title title: String, forExport: Bool = false, renderingChange monitor: Renderer.RenderingChange? = nil) -> String {
        return Configurator.shared.renderer.render(markdown: self, title: title, forExport: forExport, renderingChange: monitor)
    }
}
public final class Configurator {
    private enum Keys: String { case tags = "tags", extensions = "extensions", codeBlockAccessory = "codeBlockAccessory", tocRenderEnable = "tocRenderEnable", htmlTemplate = "htmlTemplate", htmlStyle = "htmlStyle", htmlHighlightingTheme = "htmlHighlightingTheme", htmlSyntaxHighlighting = "htmlSyntaxHighlighting", smartypantsEnable = "smartypantsEnable", frontMatterDecodeEnable = "frontMatterDecodeEnable", storeKey = "SMarkConfigurator"
    }
    private var initing = false
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
    var currentLanguages = [String]()
    var htmlTemplate = Resource.Templates.DefaultHandlebars {
        didSet {
            htmlTemplateRaw = htmlTemplate.fullPath.pathContent
            parserRenderSave()
        }
    }
    lazy var htmlTemplateRaw: String = self.htmlTemplate.fullPath.pathContent
    
    private init() {
        initing = true
        loadUserConfigure()
        initing = false
    }
    
    private func parseAndSave() {
        if initing { return }
        storeConfigure()
        renderer.parserCurrentDocument()
    }
    private func renderAndSave() {
        if initing { return }
        storeConfigure()
        renderer.renderCurrnetDocument()
    }
    private func parserRenderSave() {
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
        guard let value = UserDefault.objectForKey(Keys.storeKey.rawValue) as? [String: AnyObject] else { return }
        if let t = value[Keys.tags.rawValue] as? [NSNumber] {
            tags = t.flatMap({ SMark.HTML.Tag(rawValue: $0.unsignedIntValue) })
        }
        if let e = value[Keys.extensions.rawValue] as? [NSNumber] {
            extensions = e.flatMap({ SMark.HTML.Extension(rawValue: $0.unsignedIntValue) })
        }
        if let c = value[Keys.codeBlockAccessory.rawValue] as? Int, v = SMark.CodeBlockAccessory(rawValue: c) {
            codeBlockAccessory = v
        }
        if let h = value[Keys.htmlStyle.rawValue] as? String, v = Resource.Styles(rawValue: h) {
            htmlStyle = v
        }
        if let h = value[Keys.htmlTemplate.rawValue] as? String, v = Resource.Templates(rawValue: h) {
            htmlTemplate = v
        }
        if let h = value[Keys.htmlHighlightingTheme.rawValue] as? String, v = Resource.Prism.Themes(rawValue: h) {
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
        let tagsValue = tags.flatMap({ NSNumber(unsignedInt: $0.rawValue) })
        let extensionsValue = extensions.flatMap({ NSNumber(unsignedInt: $0.rawValue) })
        var json: [String : AnyObject] = [
            Keys.tags.rawValue : tagsValue,
            Keys.extensions.rawValue : extensionsValue,
            Keys.codeBlockAccessory.rawValue : codeBlockAccessory.rawValue,
            Keys.tocRenderEnable.rawValue : tocRenderEnable,
            Keys.htmlTemplate.rawValue : htmlTemplate.rawValue,
            Keys.htmlSyntaxHighlighting.rawValue : htmlSyntaxHighlighting,
            Keys.smartypantsEnable.rawValue : smartypantsEnable,
            Keys.frontMatterDecodeEnable.rawValue : frontMatterDecodeEnable
        ]
        json[Keys.htmlStyle.rawValue] = htmlStyle?.rawValue
        json[Keys.htmlHighlightingTheme.rawValue] = htmlHighlightingTheme?.rawValue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            UserDefault.setObject(json, forKey: Keys.storeKey.rawValue)
            UserDefault.synchronize()
        })
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



