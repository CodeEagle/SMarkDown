//
//  YAML+String.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/25.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
import YAMLFrameworkOrdered


extension String {
    private struct FronMatter {
        private static var pattern = "^-{3}\n(.*?\n)((?:-{3})|(?:\\.{3}))"
        static var regex: NSRegularExpression? {
            return try? NSRegularExpression(pattern: pattern, options: .DotMatchesLineSeparators)
        }
    }
    
    var frontMatter: (M13OrderedDictionary?, Int) {
        guard let result = FronMatter.regex?.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) else { return (nil, 0) }
        let fronmater = (self as NSString).substringWithRange(result.rangeAtIndex(1))
        do {
            let objects = try YAMLSerialization.objectsWithYAMLString(fronmater, options: kYAMLReadOptionStringScalars)
            guard let first = objects.firstObject as? M13OrderedDictionary else { return (nil, 0) }
            return (first, result.rangeAtIndex(0).length)
        } catch { return (nil, 0) }
    }
}
