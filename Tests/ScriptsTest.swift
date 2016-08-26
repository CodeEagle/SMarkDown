//
//  ScriptsTest.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/24.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import XCTest
@testable import SMarkDown

class ScriptsTest: XCTestCase {
    
    let configurator = Configurator.shared
    
    override func setUp() { super.setUp() }
    
    override func tearDown() { super.tearDown() }
    
    func testScriptWithFullLinkAndEmbedded() {
        let url = Resource.Prism.Plugins.Showlanguage.PrismShowLanguageCss.fileURL
        let sc = Scripts.StyleSheet(asset: url)
        XCTAssert(sc.html(for: .fulllink) != nil)
        XCTAssert(sc.html(for: .embedded) != nil)
    }
    
    func testBaseStyleSheet() {
        configurator.htmlStyle = nil
        XCTAssert(Scripts.baseStylesheets.count == 0)
        configurator.htmlStyle = .Github2Css
        XCTAssert(Scripts.baseStylesheets.count == 1)
    }
    
    func testPrismStyleSheet() {
        configurator.htmlHighlightingTheme = nil
        configurator.codeBlockAccessory = .none
        configurator.tags = []
        XCTAssert(Scripts.prismStylesheets.count == 0)
        configurator.htmlHighlightingTheme = .PrismOkaidiaCss
        configurator.codeBlockAccessory = .languageName
        configurator.tags = [.blockcodeLineNumber]
        XCTAssert(Scripts.prismStylesheets.count == 3)
    }
    
    func testPrismScripts() {
        configurator.currentLanguages = []
        configurator.codeBlockAccessory = .none
        configurator.tags = []
        XCTAssert(Scripts.prismScripts.count == 1)
        configurator.currentLanguages = ["swift","clike"]
        configurator.codeBlockAccessory = .languageName
        configurator.tags = [.blockcodeLineNumber]
        XCTAssert(Scripts.prismScripts.count > 0)
//        flatmap: measured [Time, seconds] average: 0.305 for 1k
//        forin: measured [Time, seconds] average: 0.278 for 1k
//        self.measureBlock {
//            for _ in 0...1000 {
//                self.configurator.currentLanguages = []
//                self.configurator.codeBlockAccessory = .none
//                self.configurator.tags = []
//                XCTAssert(Scripts.prismScripts.count == 1)
//                self.configurator.currentLanguages = ["swift","clike"]
//                self.configurator.codeBlockAccessory = .languageName
//                self.configurator.tags = [.blockcodeLineNumber]
//                XCTAssert(Scripts.prismScripts.count > 0)
//            }
//        }
    }
    
    
    func testMathJaxScript() {
        XCTAssert(Scripts.mathjaxScripts.count == 2)
    }
    
    func testChartAndSequenceScripts() {
        configurator.currentLanguages = []
        XCTAssert(Scripts.chartAndSequenceScripts.count == 0)
        configurator.currentLanguages = ["flow"]
        XCTAssert(Scripts.chartAndSequenceScripts.count == 3)
        configurator.currentLanguages = ["flow","seq"]
        XCTAssert(Scripts.chartAndSequenceScripts.count == 6)
    }
    
    
    
    
    
    
    
}
