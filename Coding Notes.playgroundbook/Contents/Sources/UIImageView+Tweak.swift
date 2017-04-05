//
//  UIImageView+Tweak.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import UIKit

extension UIImageView {
    
    override open var contentScaleFactor: CGFloat {
        
        get {
            if let image = self.image {
                
                let widthScale = self.bounds.size.width / image.size.width
                let heightScale = self.bounds.size.height / image.size.height
                
                switch self.contentMode {
                case .scaleToFill: return widthScale == heightScale ? widthScale : 1
                case .scaleAspectFit: return min(widthScale, heightScale)
                case .scaleAspectFill: return max(widthScale, heightScale)
                default: return 1
                }
            } else {
                return 1
            }
        }
        
        set {
            let center = self.center
            self.frame.size = CGSize(width: self.frame.width * newValue, height: self.frame.height * newValue)
            self.center = center
        }
    }
    
    var imageFrame: CGRect {
        
        if let image = self.image {
            
            let imageSize = image.size
            let frameSize = self.frame.size
            var resultFrame = CGRect.zero
            
            if imageSize.width < frameSize.width && imageSize.height < frameSize.height {
                resultFrame.size = imageSize
            } else {
                
                let widthRatio = imageSize.width / frameSize.width
                let heightRatio = imageSize.height / frameSize.height
                let maxRatio = max(widthRatio, heightRatio)
                resultFrame.size = CGSize(width: imageSize.width / maxRatio, height: imageSize.height / maxRatio)
            }
            
            resultFrame.origin = CGPoint(x: self.center.x - resultFrame.size.width / 2, y: self.center.y - resultFrame.size.height / 2)
            
            return resultFrame
        } else {
            return .zero
        }
    }
    
    var isPlaying: Bool {
        
        get {
            return self.isPlaying
        }
        
        set {
            if newValue {
                self.layer.shadowColor = UIColor.red.cgColor
                self.layer.shadowOffset = .zero
                self.layer.shadowOpacity = 0.9
                self.layer.shadowRadius = 5
            } else {
                self.layer.shadowColor = nil
                self.layer.shadowRadius = 0
            }
        }
    }
}
