//
//  CALayer+Extension.swift
//  testi
//
//  Created by Jawad Ali on 20/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public extension CALayer {
    
    var areAnimationsEnabled: Bool {
            get { delegate == nil }
            set { delegate = newValue ? nil : CALayerAnimationsDisablingDelegate.shared }
        }
    

    private class CALayerAnimationsDisablingDelegate: NSObject, CALayerDelegate {
        static let shared = CALayerAnimationsDisablingDelegate()
        private let null = NSNull()

        func action(for layer: CALayer, forKey event: String) -> CAAction? {
            null
        }
     }
    
       func bringToFront() {
          guard let sLayer = superlayer else {
             return
          }
          removeFromSuperlayer()
          sLayer.insertSublayer(self, at: UInt32(sLayer.sublayers?.count ?? 0))
       }

       func sendToBack() {
          guard let sLayer = superlayer else {
             return
          }
          removeFromSuperlayer()
          sLayer.insertSublayer(self, at: 0)
       }
    
    
      func animateGradientColors(from: [CGColor], to : [CGColor], duration: Double) {
          let animation = CABasicAnimation(keyPath: "colors")
          animation.fromValue = from
          animation.toValue = to
          animation.duration = duration
          animation.fillMode = .forwards
          animation.isRemovedOnCompletion = false

          // add the animation to the gradient
          self.add(animation, forKey: nil)
          
      }
    
    func strokeAnimation(duration: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        self.add(animation, forKey: "line")
    }
    
    func rotateAnimation(angal: CGFloat, duration: Double , repeatAnimation:Bool = false) {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = angal
        rotationAnimation.duration =  duration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.repeatCount = repeatAnimation ? .infinity : 0
        self.add(rotationAnimation, forKey: "rotation")
    }
    
    func removeRotationAnimation() {
        self.removeAnimation(forKey: "rotation")
    }
    
 @objc   func animateShape(path: CGPath , duration: Double)  {
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = duration
        animation.toValue = path
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
       // animation.isRemovedOnCompletion = false
        animation.fillMode = .removed
        animation.repeatCount = .infinity
        animation.autoreverses = true
        self.add(animation, forKey: nil)
        
    }
    
    func doMask(by imageMask: UIImage) {
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: imageMask.size.width, height: imageMask.size.height)
        bounds = maskLayer.bounds
        maskLayer.contents = imageMask.cgImage
        maskLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        mask = maskLayer
    }
    
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size,
                                               isOpaque,
                                               UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func rotationAnimation(angels:[CGFloat], duration: Double )  {
        
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.duration =  duration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.values = angels 
        rotationAnimation.keyTimes = [0,0.25,0.5, 0.75,1]
        
        
        self.add(rotationAnimation, forKey: "transform.rotation.z")
        
    }
}
extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension CAShapeLayer {
    public  func animateCorners(duration: Double)  {
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.duration = duration
        animation.toValue = 0.0
        animation.fromValue = bounds.midY
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.repeatCount = .infinity
        animation.autoreverses = true
        self.add(animation, forKey: nil)
        
    }
    
    func animatePosition(point:CGPoint, duration:Double) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = self.position            // animate from current position ...
        animation.toValue = point                         // ... to whereever the new position is
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       // self.position = point                       // set the shape's final position to be the new position so when the animation is done, it's at its new "home"
        self.add(animation, forKey: nil)
    }
    
    
}
