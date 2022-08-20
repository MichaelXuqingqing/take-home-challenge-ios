import Foundation
import UIKit

// MARK: - UIImageView

extension UIImageView {
    /**
     It's a simple method for the current project, used to obtain the network image resources, you can set the default image and whether to cache to the local
     Tips: Commercial projects will further refine and encapsulate this functionality, or use a full-fledged tripartite library
     
     - parameter urlStr: url string of Web image resources
     - parameter defaultImage: the placehoder image before specified web image loaded
     - parameter isCache: set whether the network image needs to be stored locally after downloading. The default value is true. If the image is used next time, it will be searched locally first
    */
    func setWebImage(urlStr: String?, defaultImage: String? = nil, isCache: Bool = true){
        var image:UIImage?
        guard let urlStr = urlStr else {
            return
        }
        if let defaultImage = defaultImage {
            self.image = UIImage(named: defaultImage)
        }
        if isCache {
            let data:Data? = ImageCacheCenter.readCacheFrom(urlString: urlStr)
            if data != nil {
                image = UIImage(data: data! as Data)
                self.image = image
            }else{
                let dispath = DispatchQueue.global(qos: .default)
                dispath.async(execute: { () -> Void in
                    if let URL = URL(string: urlStr) {
                        if let data = try? Data(contentsOf: URL) {
                            image = UIImage(data: data as Data)
                            ImageCacheCenter.writeCacheTo(urlString: urlStr, data: data)
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }
                    }
                })
            }
        }else{
            let dispath = DispatchQueue.global(qos: .default)
            dispath.async(execute: { () -> Void in
                if let URL = URL(string: urlStr) {
                    if let data = NSData(contentsOf: URL) as Data? {
                        image = UIImage(data: data as Data)
                        ImageCacheCenter.writeCacheTo(urlString: urlStr, data: data)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            })
        }
    }
}
