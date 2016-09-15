//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
extension Bool {
    var unsafePointer: UnsafeMutablePointer<ObjCBool> {
        let b = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        b.initialize(to: ObjCBool(self))
        return b
    }
}
private func path(isDirectory path: String) -> Bool {
    let isDirectory = false.unsafePointer
    let fm = FileManager.default
    if fm.fileExists(atPath: path, isDirectory: isDirectory) {
        print(isDirectory)
        return isDirectory.pointee.boolValue
    }
    return false
}
if let p = Bundle.main.path(forResource: "File", ofType: nil) {
    print(path(isDirectory: p))
}

if let p = Bundle.main.path(forResource: "folder", ofType: nil) {
    print(path(isDirectory: p))
}
