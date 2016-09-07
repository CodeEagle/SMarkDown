//
//  Scripts.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/24.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import Handlebars
protocol HTMLConvertible {
    var assetType: Scripts.ContentType { get }
    var assetURL: NSURL { get }
    var embedded: Bool { get }
    func html(for option: Scripts.Option) -> String?
}
extension HTMLConvertible {
    func context(for option: Scripts.Option) -> [String : String] {
        var context = [Scripts.Keys.typeName.rawValue : assetType.rawValue]
        let realOption = embedded ? .embedded : option
        func fulllink() { context[Scripts.Keys.url.rawValue] = assetURL.absoluteString }
        switch realOption  {
        case .embedded:
            guard assetURL.fileURL else { fulllink(); break }
            guard var text = assetURL.path?.pathContent else  { break }
            if text.hasSuffix("\n") {
                text = text.substringToIndex(text.endIndex.advancedBy(-1))
            }
            context[Scripts.Keys.content.rawValue] = text
        case .fulllink: fulllink()
        default: break
        }
        return context
    }
}
// MARK: - Scripts
struct Scripts {
    private enum Keys: String { case typeName = "typeName", content = "content", url = "url" }
    enum Option { case none, embedded, fulllink }
    enum ContentType: String {
        case plainText = "text/plain", styleSheet = "text/css", javascript = "text/javascript", mathjax = "text/x-mathjax-config"
    }
    
    // MARK: StyleSheet
    struct StyleSheet: HTMLConvertible {
        var assetURL: NSURL
        var assetType: ContentType = .styleSheet
        var embedded: Bool = false
        init(asset url: NSURL) { assetURL = url }
        
        func html(for option: Scripts.Option) -> String? {
            var template: String? = nil
            let typeName = Keys.typeName.rawValue
            let fulllink =  "<link rel=\"stylesheet\" type=\"{{ \(typeName) }}\" href=\"{{ \(Scripts.Keys.url.rawValue) }}\">"
            switch option {
            case .embedded:
                guard assetURL.fileURL else { template = fulllink; break }
                template =  "<style type=\"{{ \(typeName) }}\">\n{{{ \(Keys.content.rawValue) }}}\n</style>"
            case .fulllink: template = fulllink
            default: break
            }
            let ctx = context(for: option)
            guard let t = template where ctx.count > 0 else { return nil }
            do {
                let result  = try HBHandlebars.renderTemplateString(t, withContext: ctx)
                return result
            } catch { print(error);return nil }
        }
    }
    
    // MARK: JavaScript
    struct JavaScript: HTMLConvertible {
        var assetURL: NSURL
        var assetType: ContentType
        var embedded = false

        init(asset url: NSURL, type: ContentType = .javascript, embeded script: Bool = false) {
            assetURL = url
            assetType = type
            embedded = script
        }
        
        func html(for option: Scripts.Option) -> String? {
            var template: String? = nil
            let finalOption: Scripts.Option = embedded ? .embedded : option
            let typeName = Keys.typeName.rawValue
            let fullinkTemplate = "<script type=\"{{ \(typeName) }}\" src=\"{{ \(Scripts.Keys.url.rawValue) }}\"></script>"
            switch finalOption {
            case .embedded:
                guard assetURL.fileURL else { template = fullinkTemplate; break }
                template =  "<script type=\"{{ \(typeName) }}\">\n{{{ \(Keys.content.rawValue) }}}\n</script>"
            case .fulllink: template = fullinkTemplate
            default: break
            }
            let ctx = context(for: option)
            guard let t = template where ctx.count > 0 else { return nil }
            do {
                let result  = try HBHandlebars.renderTemplateString(t, withContext: ctx)
                return result
            } catch { print(error);return nil }
        }
    }
}

extension Scripts {
    // MARK: - stylesheets
    static var stylesheets: [StyleSheet] {
        var css = baseStylesheets
        if Configurator.shared.htmlSyntaxHighlighting {
            css.appendContentsOf(prismStylesheets)
        }
        if Configurator.shared.codeBlockAccessory == .custom {
            css.append(Resource.Extensions.ShowInformationCss.stylesheet)
        }
        return css
    }
    
    static var baseStylesheets: [StyleSheet] {
        guard let url = Configurator.shared.htmlStyle?.fileURL else { return [] }
        return [StyleSheet(asset: url)]
    }
    
    static var prismStylesheets: [StyleSheet] {
        let configurator = Configurator.shared
        var stylesheets = [StyleSheet]()
        if let theme = configurator.htmlHighlightingTheme?.stylesheet {
            stylesheets.append(theme)
        }
        if configurator.showLineNumber {
            let line = Resource.Prism.Plugins.Linenumbers.PrismLineNumbersCss.stylesheet
            stylesheets.append(line)
        }
        if configurator.showLanguageName {
            let lang = Resource.Prism.Plugins.Showlanguage.PrismShowLanguageCss.stylesheet
            stylesheets.append(lang)
        }
        return stylesheets
    }
    
    // MARK: - javascript
    static var scripts: [JavaScript] {
        var scripts = [JavaScript]()
        if Configurator.shared.usingTaskList { scripts.append(Resource.Extensions.TasklistJs.javascript) }
        scripts.appendContentsOf(prismScripts)
        scripts.appendContentsOf(mathjaxScripts)
        scripts.appendContentsOf(chartAndSequenceScripts)
        return scripts
    }
    
    static var prismScripts: [JavaScript] {
        let configurator = Configurator.shared
        if !configurator.htmlSyntaxHighlighting { return [] }
        var scripts = [JavaScript]()
        let prismCore = Resource.Prism.Components.PrismCoreMinJs.javascript
        scripts.append(prismCore)
        let languages = configurator.currentLanguages//.flatMap { (name) -> [JavaScript]? in return Resource.Prism.Components.scripts(for: name) }.flatten().flatMap({$0})
//        scripts.appendContentsOf(languages)
        for name in languages {
            scripts.appendContentsOf(Resource.Prism.Components.scripts(for: name))
        }
        if configurator.showLineNumber {
            let lineJs = Resource.Prism.Plugins.Linenumbers.PrismLineNumbersJs.javascript
            scripts.append(lineJs)
        }
        if configurator.showLanguageName {
            let languageJs = Resource.Prism.Plugins.Showlanguage.PrismShowLanguageJs.javascript
            scripts.append(languageJs)
        }
        return scripts
    }
    
    static var mathjaxScripts: [JavaScript] {
        if !Configurator.shared.renderMathJax { return [] }
        var scripts = [JavaScript]()
        let embeded = Resource.Mathjax.InitJs.javascript(.mathjax, embeded: true)
        scripts.append(embeded)
        if let main = NSURL(string: "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML") {
            scripts.append(JavaScript(asset: main))
        }
        return scripts
    }
    
    static var chartAndSequenceScripts: [JavaScript] {
        var scripts = [JavaScript]()
        let languages  = Configurator.shared.currentLanguages
        if languages.contains("flow") {
            let flowchart = Resource.Flowchartsequence.FlowchartMinJs.javascript
            let flowchatInit = Resource.Flowchartsequence.FlowchartInitJs.javascript(embeded: true)
            scripts.appendContentsOf([flowchart, flowchatInit])
        }
        if languages.contains("seq") || languages.contains("sequence") {
            let under = Resource.Flowchartsequence.UnderscoreMinJs.javascript
            let seq = Resource.Flowchartsequence.SequenceDiagramMinJs.javascript
            let seqInit = Resource.Flowchartsequence.SequenceDiagramInitJs.javascript(embeded: true)
            scripts.appendContentsOf([under, seq, seqInit])
        }
        if scripts.count > 0 {
            let raphael = Resource.Flowchartsequence.RaphaelMinJs.javascript
            scripts.insert(raphael, atIndex: 0)
        }
        return scripts
    }
}





