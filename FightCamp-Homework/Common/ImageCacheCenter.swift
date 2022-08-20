import Foundation

/**
 used to store image  data locally and read it out when needed
 In this project, it is used to cache the downloaded image resources for subsequent use
 */
class ImageCacheCenter {
    private static let cacheDetailPath = "/Library/Caches/MyCache"
    
    
    class func writeCacheTo(urlString: String, data: Data){
        let path = self.getFullCachePathFrom(urlString: urlString)
        (data as NSData).write(toFile: path as String, atomically: true)
    }
    
    class func readCacheFrom(urlString: String) -> Data?{
        var data: Data?
        let path: String = self.getFullCachePathFrom(urlString: urlString)
        if FileManager.default.fileExists(atPath: path as String) {
            data = FileManager.default.contents(atPath: path)
        }
        return data
    }
    
    class func getFullCachePathFrom(urlString: String) -> String{
        var cachePath = NSHomeDirectory().appending(cacheDetailPath)
        let fileManager: FileManager = FileManager.default
        if !(fileManager.fileExists(atPath: cachePath)) {
            try? fileManager.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        }
        let newUrlString = self.convert(str: urlString)
        cachePath = cachePath.appending("/\(newUrlString)")
        return cachePath
    }
    
    private class func convert(str: String) -> String {
        var newStr = ""
        for c in str {
            let cInt = Int(c.asciiValue!)
            if (cInt >= 48 && cInt <= 57)||(cInt >= 65 && cInt <= 90)||(cInt >= 97 && cInt <= 122){
                newStr.append(String(c))
            }
        }
        return newStr
    }
}
