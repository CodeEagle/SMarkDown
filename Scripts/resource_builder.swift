#!/usr/bin/env xcrun -sdk macosx swift





import Foundation
final class ResourceGenerator {

    enum Prism: String { case components = "components", themes = "themes", plugins = "plugins" }
    enum PrismFistLevelFile: String { case components = "components.js"}
    enum PrismPlugins: String { case showLanguage="show-language", lineNumber = "line-numbers" }

    fileprivate let logPath: String
    fileprivate let logStream: OutputStream!
    fileprivate let formatterPath: String
    fileprivate let resourcePath: String
    fileprivate let basePath: String
    fileprivate let outputPath: String
    fileprivate let pathProtocol = "FullPathProvidable"
    fileprivate var fm = FileManager.default

    init() {
        var arguments: [String] = CommandLine.arguments
        let dir = arguments.removeFirst() as NSString
        formatterPath = dir.deletingLastPathComponent + "/swiftformat"
        guard let p1 = arguments[safe: 0], let p2 = arguments[safe: 1] else {
            resourcePath = ""
            outputPath = ""
            basePath = ""
            logPath = ""
            logStream = nil
            assert(false, "not enough argument, resourcePath and outputPath ")
            return
        }
        basePath = (p1 as NSString).deletingLastPathComponent
        logPath = basePath + "/log.text"
        resourcePath = p1
        outputPath = p2
        logStream = OutputStream(toFileAtPath: logPath, append: true)
        logStream.open()
        log("😆😆😆ResourceGenerator Run😆😆")
        start()
    }

    deinit { logStream.close() }
}
// MARK: - Loop
extension ResourceGenerator {

    private func files(inDirectory dir: String) -> [String] {
        do {  return try fm.contentsOfDirectory(atPath: dir) } catch { return [] }
    }

    private func path(isDirectory path: String) -> Bool {
        let isdir = false.unsafePointer
        if fm.fileExists(atPath: path, isDirectory: isdir) {
            return isdir.pointee.boolValue
        }
        return false
    }

    fileprivate func start() {
        let list = files(inDirectory: resourcePath)
        guard list.count > 0 else { writeOutput(of: "\nNo file found in path:\(resourcePath)"); return }
        let desc = loopDirectory(at: resourcePath, name: "Resource", parent: "")
        let head = "\npublic protocol \(pathProtocol) { var fullPath: String { get } }\n"
        writeOutput(of: head + desc)
    }

    private func loopDirectory(at dirPath: String, name: String, parent: String) -> String {
        var desc = ""
        let list = files(inDirectory: dirPath)
        guard list.count > 0 else { return desc }
        desc = "\npublic enum \(removeSymbol(from: name).capitalized): String, \(pathProtocol) {\n"
        var properties = ""
        var structs = ""
        let keysHeader = "\nstatic var keys: [String] = [\n"
        var keysConent = ""
        let base = "\(parent)/\(name)"
        for item in list {
            if item == ".DS_Store" { continue }
            let p = basePath + base + "/" + item
            log("deal path :\(p)")
            log("name:\(name) item:\(item)")
            if path(isDirectory: p) {
                if item.hasPrefix(".") { continue }
                if name == "prism" && Prism(rawValue: item) == nil { continue }
                if name == "plugins" && PrismPlugins(rawValue: item) == nil { continue }
                let vname = varName(of: item)
                let subDesc = loopDirectory(at: p, name: vname, parent: base)
                structs += subDesc
            } else {
                if name == "prism" && PrismFistLevelFile(rawValue: item) == nil { continue }
                let fname = varName(of: item)
                if fname == "" { continue }
                if ["themes", "styles"].contains(name.lowercased()) {
                    keysConent += "\"\(fname)\",\n"
                }
                properties += "\ncase \(fname) =  \"\(base)/\(item)\" \n"
            }
        }
        let keys = keysHeader + keysConent + "]\n"
        desc += properties + (keysConent == "" ? "" : keys) + structs
        desc += "}\n"
        return desc
    }

    private func varName(of str: String) -> String {
        var name = ""
        var components = str.components(separatedBy: ".")
        if components.count < 2 { return str }
        let type = components.removeLast()
        let first = components.removeFirst()
        let firstPart = removeSymbol(from: first)
        let next = components.flatMap( { removeSymbol(from: $0).capitalized }).joined(separator: "")
        name = firstPart + next + type.capitalized
        return name
    }

    private func removeSymbol(from str: String) -> String {
        let pool: Set<String> = ["-","(",")",".","_"]
        var ret = ""
        var hasDealEver = false
        let t = str.trimmingCharacters(in: CharacterSet.whitespaces)

        var seps = Set<String>()
        for sep in pool {
            if t.contains(sep) {
                hasDealEver = true
                seps.insert(sep)
            }
        }
        if hasDealEver {
            var strTo = t
            for item in seps {
                let ar = strTo.components(separatedBy: item)
                strTo = ar.flatMap({$0.capitalized}).joined(separator: "")
            }
            ret += strTo.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "+", with: "Plus")
        } else {
            if str.characters.count > 0 {
                ret += t.capitalized.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "+", with: "Plus")
            }
        }
        return ret
    }

}
// MARK: - output
private extension ResourceGenerator {

    func writeOutput(of content: String) {
        log("deal path :\(outputPath), content:\(content)")
        let header = "//  Resource\n//  Formated By swiftformat\n//  Created by LawLincoln \n//  Copyright © 2016年 LawLincoln. All rights reserved."
        let total = header + content
        let data = total.data(using: String.Encoding.utf8)
        do {
            let url = URL(fileURLWithPath: outputPath)
            try data?.write(to: url, options: Data.WritingOptions.atomic)
            changePermission()
            formatCode()
        } catch { }
    }

    func changePermission() {
        let task = Process()
        task.launchPath = "/bin/chmod"
        task.arguments = ["755", formatterPath]
        task.launch()
    }

    func formatCode() {
        let task = Process()
        task.launchPath = formatterPath
        task.arguments = [outputPath, "-i", "4", outputPath]
        task.launch()
    }
}

// MARK: - Log
private extension ResourceGenerator {

    func log(_ item: String) {
        //  guard let data = "\(item)\n".dataUsingEncoding(NSUTF8StringEncoding) else { return }
        //  logStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
    }
}
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Bool {
    var unsafePointer: UnsafeMutablePointer<ObjCBool> {
        let b = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        b.initialize(to: ObjCBool(self))
        return b
    }
}
_ = ResourceGenerator()
