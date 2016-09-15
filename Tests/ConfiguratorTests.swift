//
//  ConfiguratorTests.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/24.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import XCTest
@testable import SMarkDown
class ConfiguratorTests: XCTestCase {
    
    override func setUp() { super.setUp() }
    
    override func tearDown() { super.tearDown() }
    
    func testStore() {
        Configurator.shared.tags = [.useTaskList, .blockcodeLineNumber]
    }
    
    func testRead() {
        assert(Configurator.shared.tags == [.useTaskList, .blockcodeLineNumber], "not equal to store")
    }
    
    func asyncTest(_ timeout: TimeInterval = 60, block: (XCTestExpectation) -> ()) {
        let expectation: XCTestExpectation = self.expectation(description: "Swift Expectations")
        block(expectation)
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if error != nil {
                XCTFail("time out: \(error)")
            } else {
                XCTAssert(true, "success")
            }
        }
    }
    func testFrontMatter() {
        let configure = Configurator.shared
        configure.frontMatterDecodeEnable = true
        configure.tocRenderEnable = true
        configure.tags = [.useTaskList]
        configure.extensions = [.footnotes, .tables, .fencedCode, .math, .mathExplicit]
        if let path = Bundle(for: Renderer.self).path(forResource: "frontmatter", ofType: nil) {
            do {
                let content = try String(contentsOfFile: path)
                let html = content.htmlWith(title: "Test", forExport: false)
                updatePreview(html)
            } catch{ }
        }
    }
    
    func updatePreview(_ content: String) {
        let path = NSTemporaryDirectory() + "preview.html"
        guard let data = content.data(using: String.Encoding.utf8) else { return }
        do {
            print(path)
            try data.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
            #if os(OSX)
                let task = Process()
                task.launchPath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
                task.arguments = [" ", path]
                task.launch()
            #endif
        } catch { }
        
    }
}
