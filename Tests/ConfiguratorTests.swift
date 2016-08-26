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
    
    func asyncTest(timeout: NSTimeInterval = 60, block: (XCTestExpectation) -> ()) {
        let expectation: XCTestExpectation = expectationWithDescription("Swift Expectations")
        block(expectation)
        waitForExpectationsWithTimeout(timeout) { (error) -> Void in
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
        if let path = NSBundle(forClass: Renderer.self).pathForResource("frontmatter", ofType: nil) {
            do {
                let content = try String(contentsOfFile: path)
                let html = content.htmlWith(title: "Test", forExport: false)
                updatePreview(html)
            } catch{ }
        }
    }
    
    func updatePreview(content: String) {
        let path = NSTemporaryDirectory() + "preview.html"
        guard let data = content.dataUsingEncoding(NSUTF8StringEncoding) else { return }
        do {
            print(path)
            try data.writeToFile(path, options: .AtomicWrite)
            #if os(OSX)
                let task = NSTask()
                task.launchPath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
                task.arguments = [" ", path]
                task.launch()
            #endif
        } catch { }
        
    }
}
