//
//  UIButton+LPActivity.swift
//  Pods
//
//  Created by Timothy Dillman on 7/24/17.
//
//

import UIKit
@IBDesignable
open class UIButton_LPActivity: UIButton {
    @IBInspectable open var cRadius:CGFloat = 0.0
    @IBInspectable open var borderColor:UIColor = UIColor.clear
    @IBInspectable open var borderWidth:CGFloat = 0.0
    private var activityView:UIActivityIndicatorView?
    private var currentButtonTitle:String?
    open override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
    
    public func beginActivity() {
        DispatchQueue.main.async {
            self.currentButtonTitle = self.titleLabel?.text
            self.setTitle(nil, for: .normal)
            self.isEnabled = false
            self.activityView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            self.activityView?.autoresizingMask = [UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
            self.activityView?.center = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
            self.addSubview(self.activityView!)
            self.activityView?.startAnimating()
        }
    }
    
    public func beginActivity(withLoaderView view: UIActivityIndicatorView) {
        self.currentButtonTitle = self.titleLabel?.text
        self.setTitle(nil, for: .normal)
        self.isEnabled = false
        self.activityView = view
        self.activityView?.autoresizingMask = [UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
        self.activityView?.center = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        self.addSubview(self.activityView!)
        self.activityView?.startAnimating()
    }
    
    public func endActivity() {
        DispatchQueue.main.async { [unowned self] in
            /* set the button's title back and enable functionality */
            self.setTitle(self.currentButtonTitle, for: .normal)
            self.isEnabled = true
            self.activityView = nil
            /* find and remove activity view if any exists */
            for view in self.subviews {
                if view.isKind(of: UIActivityIndicatorView.self) {
                    view.removeFromSuperview()
                }
            }
        }
    }

}
