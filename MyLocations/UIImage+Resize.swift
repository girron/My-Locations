//
//  UIImage+Resize.swift
//  MyLocations
//
//  Created by Jack Burton on 8/7/16.
//  Copyright © 2016 Pork Chop Express. All rights reserved.////

import UIKit

extension UIImage {
    func resizedImageWithBounds(_ bounds: CGSize) -> UIImage {
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
