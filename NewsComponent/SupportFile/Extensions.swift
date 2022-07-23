//
//  Extensions.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import Foundation
import UIKit
import ImageIO

extension UIColor {
    //MARK: Custom with Hex Color
    static func getColorWith(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexStr: hex))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
    
        return ceil(boundingBox.width)
    }
}

extension UIImage {
    func resizeImage(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
         let widthRatio  = width / size.width
         let heightRatio = height / size.height
         let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
         let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
         let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContext(newSize)
         self.draw(in: rect)
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return newImage
     }
}
extension UIImageView {
    func loadImage(with image: String, name: String, id: String) {
        Network.downloadImageCache(image, nameKey: name + id) { [weak self] img in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = img
            }
        }
    }
}
