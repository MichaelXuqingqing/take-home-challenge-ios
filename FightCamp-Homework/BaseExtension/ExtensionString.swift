import Foundation
import UIKit

// MARK: - String

extension String {
    /**
     Based on the attributes of the string and the fixed width, the line height required for display is automatically calculated
     
     - parameter font: the font of the label showing the string
     - parameter width: the fixed width of the label showing the string
     - parameter attributes: the text attributes of the label showing the string, it is optinal
    */
    func getLabelHeight(font: UIFont, width: CGFloat, attributes: [NSAttributedString.Key: AnyObject]?) -> CGFloat {
        if self.isEmpty {
            return 0.0
        }
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        var dic: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key.font: font]
        if let attributes = attributes {
            for (key, value) in attributes {
                dic[key] = value
            }
        }
        let strSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context: nil).size
        return strSize.height
    }
}
