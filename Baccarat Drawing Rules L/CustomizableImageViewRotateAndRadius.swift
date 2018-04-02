//
//  CustomizableImageViewRotateAndRadius.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam on 06/03/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageViewRotateAndRadius: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
            transform = CGAffineTransform(rotationAngle: .pi / 2);
        }
    }
}

