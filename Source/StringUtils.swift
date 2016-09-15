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
    fileprivate struct FronMatter {
        fileprivate static var pattern = "^-{3}\n(.*?\n)((?:-{3})|(?:\\.{3}))"
        static var regex: NSRegularExpression? {
            return try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
        }
    }
    
    var frontMatter: (M13OrderedDictionary<NSString, AnyObject>?, Int) {
        guard let result = FronMatter.regex?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) else { return (nil, 0) }
        let fronmater = (self as NSString).substring(with: result.rangeAt(1))
        do {
            let objects = try YAMLSerialization.objects(withYAMLString: fronmater, options: kYAMLReadOptionStringScalars)
            guard let first = objects.firstObject as? M13OrderedDictionary<NSString, AnyObject> else { return (nil, 0) }
            return (first, result.rangeAt(0).length)
        } catch { return (nil, 0) }
    }
}






