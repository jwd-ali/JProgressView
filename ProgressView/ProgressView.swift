//
//  ProgressView.swift
//  testi
//
//  Created by Jawad Ali on 31/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

open class ProgressView: UIView {
    
    private lazy var shape1 = CAShapeLayer()
    private lazy var shape2 = CAShapeLayer()
    private lazy var shape3 = CAShapeLayer()
    private lazy var shape4 = CAShapeLayer()
    
    private  var colors = [#colorLiteral(red: 0.5502940416, green: 0.8689419627, blue: 0.9688422084, alpha: 1),#colorLiteral(red: 0.9374079108, green: 0.7400206923, blue: 1, alpha: 1),#colorLiteral(red: 0.6756847501, green: 0.7432909608, blue: 0.9375373721, alpha: 1),#colorLiteral(red: 0.9669341445, green: 0.646687448, blue: 0.7728756666, alpha: 1)] {
        didSet{
            layoutIfNeeded()
        }
    }
    
    private lazy var shapesCollection = [shape1, shape2, shape3, shape4]
    
    convenience init(colors: [UIColor]) {
        self.init(frame: .zero)
        
        if colors.count < 4 {  fatalError("Please provide four colors to progress view")  }
        self.colors = colors
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }
    
    private func controlDidLoad(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        shapesCollection.forEach { (shape) in
            layer.addSublayer(shape)
            shape.masksToBounds = true
        }
    }
    
    open override func layoutSubviews() {
        
        updatePaths()
        for (index, shape ) in shapesCollection.enumerated() {
            shape.fillColor = colors[index].cgColor
        }
    }
    
    private func updatePaths() {
        
        
        let size = bounds.width/2 -  bounds.width * 0.1
        
        
        let p1bounds = CGRect(origin: .zero, size: CGSize(width: size, height: size ))
        
        let p2bounds = CGRect(origin: CGPoint(x:bounds.width/2 + bounds.width * 0.1 , y: 0), size: CGSize(width: size, height: size ))
        
        let p3bounds = CGRect(origin: CGPoint(x:0 , y:bounds.height/2 + bounds.width * 0.1 ), size: CGSize(width: size , height:size))
        
        let p4bounds = CGRect(origin: CGPoint(x:bounds.width/2 + bounds.width * 0.1 , y:bounds.height/2  + bounds.width * 0.1), size: CGSize(width: size , height: size ))
        
        let allBounds = [p1bounds, p2bounds, p3bounds, p4bounds]
        
        let bezierPath = UIBezierPath(rect: p1bounds)
        
        for (index, shape ) in shapesCollection.enumerated() {
            shape.cornerRadius = size/2
            shape.path = bezierPath.cgPath
            shape.frame = allBounds[index]
        }
        
    }
    
    public func stopAnimating() {
        shapesCollection.forEach { (shape) in
            shape.removeAllAnimations()
        }
        layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
    private func setUpConstraints(with view: UIView) {
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    public  func StartAnimating(in view : UIView) {
 
        view.addSubview(self)
        setUpConstraints(with: view)
        self.layoutIfNeeded()
        
        let size = bounds.width/2 -  bounds.width * 0.1
        let gap : CGFloat = 0.01
        let p1bounds = CGRect(origin: CGPoint(x: bounds.midX - size - bounds.width * gap, y: bounds.midY - size - bounds.height * gap), size: CGSize(width: size, height: size ))
        
        let p2bounds = CGRect(origin: CGPoint(x:bounds.midX  + bounds.width * gap , y: bounds.midY - size - bounds.height * gap), size: CGSize(width: size, height: size ))
        
        let p3bounds = CGRect(origin: CGPoint(x:bounds.midX - size - bounds.width * gap , y:bounds.midY +  bounds.height * gap), size: CGSize(width: size , height:size))
        
        let p4bounds = CGRect(origin: CGPoint(x:bounds.midX  + bounds.width * gap , y:bounds.midY +  bounds.height * gap), size: CGSize(width: size , height: size ))
        
        let allBounds = [p1bounds, p2bounds, p3bounds, p4bounds]
        
        let duration = 0.5
        
        
        
        for (index, shape ) in shapesCollection.enumerated() {
            
            shape.animateCorners(duration: duration)
            shape.animatePosition(point: CGPoint(x: allBounds[index].midX, y: allBounds[index].midY), duration: duration)
        }
        
        self.layer.rotationAnimation(angels: [0,-100.degreesToRadians,0,100.degreesToRadians,0], duration: duration * 4)
    }
    
    
    
}
