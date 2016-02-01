// Copyright (c) 2014 evolved.io (http://evolved.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import QuartzCore
import UIKit

public class AnimatedMenuButton : UIButton {
    
    let menuTop: CAShapeLayer = CAShapeLayer()
    let menuMiddle: CAShapeLayer = CAShapeLayer()
    let menuBottom: CAShapeLayer = CAShapeLayer()
    
    // MARK: - Constants
    
    let animationDuration: CFTimeInterval = 8.0
    
    let shortStroke: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 2, 2)
        CGPathAddLineToPoint(path, nil, 30 - 2 * 2, 2)
        return path
        }()
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
                
        self.menuTop.path = shortStroke;
        self.menuMiddle.path = shortStroke;
        self.menuBottom.path = shortStroke;
        
        for layer in [ self.menuTop, self.menuMiddle, self.menuBottom ] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.grayColor().CGColor
            layer.lineWidth = 4
            layer.miterLimit = 2
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            
            layer.actions = [
                "opacity": NSNull(),
                "transform": NSNull()
            ]
            
            self.layer.addSublayer(layer)
        }
        
        self.menuTop.anchorPoint = CGPoint(x: 1, y: 0.5)
        self.menuTop.position = CGPoint(x: 30 - 1, y: 5)
        self.menuMiddle.position = CGPoint(x: 15, y: 15)
        
        self.menuBottom.anchorPoint = CGPoint(x: 1, y: 0.5)
        self.menuBottom.position = CGPoint(x: 30 - 1, y: 25)
    }
    
    // MARK: - Animations
    
    public func animateWithPercentVisible(percentVisible:CGFloat, drawerSide: DrawerSide) {
        
        if drawerSide == DrawerSide.Left {
            self.menuTop.anchorPoint = CGPoint(x: 1, y: 0.5)
            self.menuTop.position = CGPoint(x: 30 - 1, y: 5)
            self.menuMiddle.position = CGPoint(x: 15, y: 15)
            
            self.menuBottom.anchorPoint = CGPoint(x: 1, y: 0.5)
            self.menuBottom.position = CGPoint(x: 30 - 1, y: 25)
        } else if drawerSide == DrawerSide.Right {
            self.menuTop.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.menuTop.position = CGPoint(x: 1, y: 5)
            self.menuMiddle.position = CGPoint(x: 15, y: 15)
            
            self.menuBottom.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.menuBottom.position = CGPoint(x: 1, y: 25)
        }
        
        let middleTransform = CABasicAnimation(keyPath: "opacity")
        middleTransform.duration = animationDuration
        
        let topTransform = CABasicAnimation(keyPath: "transform")
        topTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
        topTransform.duration = animationDuration
        topTransform.fillMode = kCAFillModeBackwards
        
        let bottomTransform = topTransform.copy() as! CABasicAnimation
        
        middleTransform.toValue = 1 - percentVisible
        
        let translation = CATransform3DMakeTranslation(-4 * percentVisible, 0, 0)
        
        let sideInverter: CGFloat = drawerSide == DrawerSide.Left ? -1 : 1
        topTransform.toValue = NSValue(CATransform3D: CATransform3DRotate(translation, 1.0 * sideInverter * ((CGFloat)(45.0 * M_PI / 180.0) * percentVisible), 0, 0, 1))
        bottomTransform.toValue = NSValue(CATransform3D: CATransform3DRotate(translation, (-1.0 * sideInverter * (CGFloat)(45.0 * M_PI / 180.0) * percentVisible), 0, 0, 1))

        topTransform.beginTime = CACurrentMediaTime()
        bottomTransform.beginTime = CACurrentMediaTime()
        
        self.menuTop.addAnimation(topTransform, forKey: topTransform.keyPath)
        self.menuMiddle.addAnimation(middleTransform, forKey: middleTransform.keyPath)
        self.menuBottom.addAnimation(bottomTransform, forKey: bottomTransform.keyPath)
        
        self.menuTop.setValue(topTransform.toValue, forKey: topTransform.keyPath!)
        self.menuMiddle.setValue(middleTransform.toValue, forKey: middleTransform.keyPath!)
        self.menuBottom.setValue(bottomTransform.toValue, forKey: bottomTransform.keyPath!)
    }
}