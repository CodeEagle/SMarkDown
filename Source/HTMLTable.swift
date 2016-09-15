//
//  HTMLTable.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/25.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import Handlebars
import YAMLFrameworkOrdered
private struct Constant {
    static var escape = HBEscapingFunctions.htmlEscapingFunction()
    static var arrayTemplate = "<table><tbody><tr>{{#each objects}}<td>{{{HTMLTable this}}}</td>{{/each}}</tr></tbody></table>"
    static var helper: [AnyHashable: Any] = {
        var block : @convention(block) (HBHelperCallingInfo) -> NSString = {
            (info : HBHelperCallingInfo) -> NSString in
            return (info.positionalParameters[safe: 0] as? NSObject)?.HTMLTable as NSString? ?? ""
        }
        return ["HTMLTable": unsafeBitCast(block, to: AnyObject.self)]
    }()
    
    static var dictTemplate = "<table><thead><tr>{{#each keys}}<th>{{{HTMLTable this}}}</th>{{/each}}</tr></thead><tbody><tr>{{#each objects}}<td>{{{HTMLTable this}}}</td>{{/each}}</tr></tbody></table>"
    
    static var m13Template = "<table><thead><tr>{{#each keys}}<th>{{{HTMLTable this}}}</th>{{/each}}</tr></thead><tbody><tr>{{#each objects}}<td>{{{HTMLTable this}}}</td>{{/each}}</tr></tbody></table>"
    
}

private var escape: HBEscapingFunction? = nil
private var token: Int = 0
extension NSObject {
    
    var HTMLTable: String {
        if let obj = self as? M13OrderedDictionary<NSString,AnyObject> {
            let template = Constant.m13Template
            let context = ["objects" : obj.allObjects, "keys": obj.allKeys] as [String : Any]
            let table = try? HBHandlebars.renderTemplateString(template, withContext: context, withHelperBlocks: Constant.helper)
            return table ?? ""
        }
        return Constant.escape!(description) ?? ""
    }
    
    func validKeysForHandlebars() -> [String] { return ["HTMLTable"] }
}

extension NSNull {
    override var HTMLTable: String { return "" }
}

extension NSArray {
    override var HTMLTable: String {
        let template = Constant.arrayTemplate
        let context = ["objects" : self]
        let table = try? HBHandlebars.renderTemplateString(template, withContext: context, withHelperBlocks: Constant.helper)
        return table ?? ""
    }
}

extension NSDictionary {
    
    override var HTMLTable: String {
        let template = Constant.dictTemplate
        let context = ["objects" : allValues, "keys": allKeys]
        let table = try? HBHandlebars.renderTemplateString(template, withContext: context, withHelperBlocks: Constant.helper)
        return table ?? ""
    }
}


