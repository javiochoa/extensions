//
//  UIView+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import Foundation
import UIKit

extension UIView {

    
    func applyGradient(colours: [UIColor]) -> Void {
        
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = locations
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addGradient() {
        
        self.applyGradient(colours: [
            UIColor.gradientLightColor,
            UIColor.mainColor,
            UIColor.mainColor,
            UIColor.gradientDarkColor],
                           locations: [0.0, 0.4, 0.63, 1.0])
    }
    
    func removeGradient() -> Void {
        
        if let sublayersUnwrapped: [CALayer] = self.layer.sublayers {
            for layer in sublayersUnwrapped {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func dropShadow(scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.3, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    func makeCircle() -> Void {
        
        layer.cornerRadius = frame.size.height/2
    }
    
    func roundCorners() -> Void {
        
        layer.cornerRadius = 4
    }
    
    func roundCorners(radius:CGFloat) -> Void {
        
        layer.cornerRadius = radius
    }
    
    func bordered(withColor:UIColor, borderWidth:CGFloat) -> Void {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = withColor.cgColor
    }
    
    func drawGradientOver(colors:[CGColor]) {
        
        let maskLayer = CAGradientLayer()
        maskLayer.opacity = 0.8
        maskLayer.colors = colors//
        
        // Hoizontal - commenting these two lines will make the gradient veritcal
        maskLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        maskLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let gradTopStart = NSNumber(value: 0.0)
        let gradTopEnd = NSNumber(value: 0.4)
        let gradBottomStart = NSNumber(value: 0.6)
        let gradBottomEnd = NSNumber(value: 1.0)
        maskLayer.locations = [gradTopStart, gradTopEnd, gradBottomStart, gradBottomEnd]
        
        maskLayer.bounds = self.bounds
        maskLayer.anchorPoint = CGPoint.zero
        self.layer.addSublayer(maskLayer)
    }
    
    func drawGradient(startPoint: CGPoint, endPoint: CGPoint) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = UIScreen.main.bounds
        if let sublayers = self.layer.sublayers, sublayers[0].isKind(of: CAGradientLayer.self) {
            sublayers[0].removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    enum Border: Int {
        
        case left
        case right
        case top
        case bottom
    }
    
    private final class BorderView: UIView { }
    
    func addBorder(_ border: Border, weight: CGFloat, color: UIColor) {
        
        resetBorder(border)
        let lineView = BorderView()
        lineView.tag = border.rawValue
        addSubview(lineView)
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        switch border {
            
        case .left:
            lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            lineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            lineView.widthAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .right:
            lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            lineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            lineView.widthAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .top:
            lineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .bottom:
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: weight).isActive = true
        }
    }
    
    func resetBorder(_ border: Border) {
        
        self.subviews.filter{ $0 is BorderView && $0.tag == border.rawValue }.forEach { $0.removeFromSuperview() }
    }
    
    func bindFrameToSuperviewBounds() {
        
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
    
    func fixInView(_ container: UIView!) -> Void {
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        container.layer.cornerRadius = 5.0
    }
}

@IBDesignable
final class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}
