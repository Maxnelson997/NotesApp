//
//  extension.swift
//  NotesiOSApp
//
//  Created by Max Nelson on 3/21/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var primaryColor = UIColor.init(rgb: 0xE0BE53)
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIView {
    
    enum ViewSide {
        case left, right, bottom, top
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
    
        switch side {

        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        case .top:
           border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
    
    
}
