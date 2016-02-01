//
//  UIImage+Ext.swift
//  SocialCOX
//
//  Created by Evgeny Abramov on 6/4/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func imageMaskedWith(color: UIColor) -> UIImage {
        let imageRect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -(imageRect.size.height))
        
        CGContextClipToMask(context, imageRect, CGImage)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imageWithColor2(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context  = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)

        let rect     = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        color1.setFill()
        CGContextFillRect(context, rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }
    
    func roundImage() -> UIImage {
        let nSize = CGSize(width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(nSize,false,UIScreen.mainScreen().scale);
        let context = UIGraphicsGetCurrentContext();
        
        // Background
        
        CGContextAddPath(context, CGPathCreateWithEllipseInRect(CGRect(origin: CGPointZero, size: nSize),nil));
        CGContextClip(context);
        self.drawInRect(CGRect(origin: CGPointMake(-1, -1), size: CGSize(width: (self.size.width+2), height: (self.size.height+2))));
        
        // Border
        
        CGContextSetStrokeColorWithColor(context, UIColor(red: 0, green: 0, blue: 0, alpha: 0x19/255.0).CGColor);
        CGContextAddArc(context,CGFloat(self.size.width)/2, CGFloat(self.size.width)/2, CGFloat(self.size.width)/2, CGFloat(M_PI * 0), CGFloat(M_PI * 2), 0);
        CGContextDrawPath(context, CGPathDrawingMode.Stroke);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
}