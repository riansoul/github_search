//
//  UIView+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit

extension UIView {
        
    func startRotate(with duration: TimeInterval = 1.1, `repeat`: Float = Float.infinity) {
        if self.layer.animation(forKey: "Spin") != nil {
            return
        }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = NSNumber(value: 0)
        rotation.toValue = NSNumber(value: 2 * Double.pi)
        rotation.duration = duration
        rotation.repeatCount = `repeat`
        self.layer.add(rotation, forKey: "Spin")
    }
    
    func stopRotate() {
        self.layer.removeAnimation(forKey: "Spin")
    }
    
    func rotate(with duration: TimeInterval = 0.3, degree: Double) {
        UIView.animate(withDuration: duration) {
            let angle = CGFloat(degree * Double.pi / 180.0)
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    func loadViewFromNib(frame: CGRect) {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            addSubview(view)
        }
    }
    
    func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(view)
            
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    func drawOutline(with color: CGColor = UIColor.red.cgColor, name: String? = nil) {
        layer.borderColor = color
        layer.borderWidth = 1
        
        let text = name ?? String(describing: type(of: self))
        
        let label = UILabel()
        label.text = text
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.sizeToFit()
        
        addSubview(label)
    }
    
    func animate(withDuration duration: TimeInterval = 0.3, constraint: NSLayoutConstraint, constant: CGFloat) {
        constraint.constant = constant
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func addSubviewAutoLayout(_ view: UIView) {
        addSubview(view)
        
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func makeImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func toRound() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    func setGradient(start: UIColor, end: UIColor) {
        if let layer = layer.sublayers?.first, layer is CAGradientLayer {
            layer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [start.cgColor, end.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func isHiddenGradient(hidden: Bool) {
        if let layer = layer.sublayers?.first, layer is CAGradientLayer {
            layer.isHidden = hidden
        }
    }
    
    func shake() {
        let leftShake = CGAffineTransform(translationX: -5, y: 0)
        let rightShake = CGAffineTransform(translationX: 0, y: 0)
        transform = leftShake;
        
        UIView.beginAnimations("shake", context: nil)
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationRepeatCount(3)
        UIView.setAnimationDuration(0.05)
        
        transform = rightShake
        
        UIView.commitAnimations()
    }
    
    func animateFadeIn(with duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 1.0
        })
    }
    
    func animateFadeout(with duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0.0
        })
    }
    
    func animateFadeInOut(with duration: TimeInterval = 0.3, delay: TimeInterval = 3.0) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseInOut, animations: { [weak self] in
                self?.alpha = 0.0
                }, completion: nil)
        }
    }
    
    func animateHidden(_ hidden: Bool) {
        if hidden {
            animateFadeout()
        } else {
            animateFadeIn()
        }
    }
    
    func animateMoveHorison(x:CGFloat) {
        let yPosition = self.frame.origin.y
        let height = self.frame.height
        let width = self.frame.width
        self.frame = CGRect(x: x, y: yPosition, width: width, height: height)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.updateConstraints()
        self.layoutIfNeeded()
        
    }
    
    func animateMoveVertical(y:CGFloat) {
        let xPosition = self.frame.origin.x
        let height = self.frame.height
        let width = self.frame.width
        self.frame = CGRect(x: xPosition, y: y, width: width, height: height)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.updateConstraints()
        self.layoutIfNeeded()
        
    }
    
    
}

extension UIView {
    
    var widthConstraint: NSLayoutConstraint? {
        return constraints.filter { $0.firstAttribute == .width }.first
    }
    
    var heightConstraint: NSLayoutConstraint? {
        return constraints.filter { $0.firstAttribute == .height }.first
    }
    
    var topConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .top }.first
    }
    
    var bottomConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .bottom }.first
    }
    
    var leadingConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .leading }.first
    }
    
    var trailingConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .trailing }.first
    }
    
    var centerYConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .centerY }.first
    }
    
    var centerXConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter { ($0.firstItem as? UIView) == self || ($0.secondItem as? UIView) == self }
            .filter { $0.firstAttribute == .centerX }.first
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

