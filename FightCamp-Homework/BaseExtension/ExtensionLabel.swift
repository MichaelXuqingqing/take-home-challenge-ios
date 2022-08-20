import Foundation
import UIKit

// MARK: - UILabel

extension UILabel {
    /**
     Set the line spacing to a multiple
     
     - parameter multipleValue: the value of the line spacing is a multiple
     */
    func setLineHeightMultiple(_ multipleValue: CGFloat) {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = multipleValue
        var attributedText = self.attributedText
        if attributedText == nil {
            attributedText = NSMutableAttributedString(string: self.text ?? "")
        }
        let text = NSMutableAttributedString(attributedString: attributedText!)
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.length))
        self.attributedText = text
    }
    
    /**
     Add Strikethrough to the label
     */
    func setStrikethrough() {
        var attributedText = self.attributedText
        if attributedText == nil {
            attributedText = NSMutableAttributedString(string: self.text ?? "")
        }
        let text = NSMutableAttributedString(attributedString: attributedText!)
        text.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: text.length))
        self.attributedText = text
    }
}
