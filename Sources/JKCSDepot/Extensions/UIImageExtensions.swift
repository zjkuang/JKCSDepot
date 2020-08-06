//
//  UIImageExtensions.swift
//  ImagePickerSwiftUI
//
//  Created by Zhengqian Kuang on 2019-09-25.
//  Copyright © 2019 Zhengqian Kuang. All rights reserved.
//

import UIKit

public extension UIImage {

    // https://stackoverflow.com/a/49916464/7455975
    func upOrientationImage() -> UIImage? {
        switch imageOrientation {
        case .up:
            return self
            
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }

    // https://stackoverflow.com/a/24545102/7455975
    func imageWithColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
