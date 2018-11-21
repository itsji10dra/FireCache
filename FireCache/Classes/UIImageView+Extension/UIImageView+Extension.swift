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
    
    @discardableResult
    public func setImage(with url: URL, placeholder: UIImage? = nil) -> FireDownloadTask<UIImage>? {
        
        self.imageURL = url
        self.image = placeholder
        
        return FireImageManager.shared.fetch(with: url) { [weak self] (image, url, _) in
            DispatchQueue.main.async {
                guard let strongSelf = self, url == strongSelf.imageURL else { return }
                strongSelf.image = image
            }
        }
    }
}
