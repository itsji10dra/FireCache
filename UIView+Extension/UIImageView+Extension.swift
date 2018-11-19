//
//  UIImageView+Extension.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

import UIKit
import Foundation

private var kURLKey: Void?

extension UIImageView {
    
    // MARK: - Private
    
    private var imageURL: URL? {
        set { objc_setAssociatedObject(self, &kURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, &kURLKey) as? URL }
    }
    
    // MARK: - Public
    
    public func setImage(with url: URL, placeholder: UIImage? = nil) {
        
        self.imageURL = url
        self.image = placeholder
        
        FireImageManager.shared.fetch(with: url) { [weak self] (image, url) in
            DispatchQueue.main.async {
                guard let strongSelf = self, url == strongSelf.imageURL else { return }
                strongSelf.image = image
            }
        }
    }
}
