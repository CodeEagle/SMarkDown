//
//  Extensions.swift
//  SMarkDown
//
//  Created by LawLincoln on 16/8/24.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import Foundation
#if os(OSX)
let BundleBasePath: String = NSBundle(forClass: Renderer.self).bundlePath + "/Versions/A/Resources"
#elseif os(iOS)
let BundleBasePath: String = NSBundle(forClass: Renderer.self).bundlePath
#endif

extension RawRepresentable where RawValue == String, Self: FullPathProvidable {
    public var fullPath: String { return BundleBasePath + rawValue }
    public var fileURL: NSURL { return NSURL(fileURLWithPath: fullPath) }
    var javascript: Scripts.JavaScript { return Scripts.JavaScript(asset: fileURL) }
    func javascript(type: Scripts.ContentType = .javascript, embeded: Bool = false) -> Scripts.JavaScript { return Scripts.JavaScript(asset: fileURL, type: type, embeded: embeded) }
    var stylesheet: Scripts.StyleSheet { return Scripts.StyleSheet(asset: fileURL) }
}

extension String {
    var pathContent: String {
        do { return try String(contentsOfFile: self) } catch { return "" }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index]: nil
    }
}

extension Resource.Prism.Components {
    static func scripts(for language: String) -> [Scripts.JavaScript] {
        var scripts: [Scripts.JavaScript] = []
        let name = language.lowercaseString
        let enumBase = "/Resource/prism/components/"
        let base = "prism-\(name)"
        let extra = "prism-\(name)-extras"
        let extensionNames = [".min.js",".js"]
        var baseScript: Resource.Prism.Components?
        var extraScript: Resource.Prism.Components?
        for ext in extensionNames {
            let baseRaw = enumBase + base + ext
            let extRaw = enumBase + extra + ext
            if baseScript == nil { baseScript = Resource.Prism.Components(rawValue: baseRaw) }
            if extraScript == nil { extraScript = Resource.Prism.Components(rawValue: extRaw) }
        }
        if let b = baseScript?.javascript { scripts.append(b) }
        if let b = extraScript?.javascript { scripts.append(b) }
        return scripts
    }
}