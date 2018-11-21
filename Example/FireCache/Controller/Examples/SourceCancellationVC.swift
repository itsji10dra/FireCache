//
//  SourceCancellationVC.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

class SourceCancellationVC: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var imageView1: UIImageView!

    @IBOutlet weak var statusLabel2: UILabel!
    @IBOutlet weak var imageView2: UIImageView!

    @IBOutlet weak var statusLabel3: UILabel!
    @IBOutlet weak var imageView3: UIImageView!

    @IBOutlet weak var statusLabel4: UILabel!
    @IBOutlet weak var imageView4: UIImageView!

    @IBOutlet weak var statusLabel5: UILabel!
    @IBOutlet weak var imageView5: UIImageView!

    // MARK: - CacheManager

    let fireManager = FireManager<UIImage>()
    
    // MARK: - Data
    
    let url: URL? = URL(string: "https://images.unsplash.com/photo-1464550838636-1a3496df938b")
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = self.url else { return }
        
        statusLabel1.text = "Starting loading"
        let _ = fireManager.fetch(with: url) { [weak self] (image, url, error) in
            DispatchQueue.main.async {
                if let image = image {
                        self?.imageView1.image = image
                        self?.statusLabel1.text = "Image Loaded Successfully"
                } else if let error = error {
                    self?.statusLabel1.text = error.localizedDescription
                }
            }
        }
        
        statusLabel2.text = "Starting loading"
        let _ = fireManager.fetch(with: url) { [weak self] (image, url, error) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView2.image = image
                    self?.statusLabel2.text = "Image Loaded Successfully"
                } else if let error = error {
                    self?.statusLabel2.text = error.localizedDescription
                }
            }
        }

        statusLabel3.text = "Starting loading"
        let task3 = fireManager.fetch(with: url) { [weak self] (image, url, error) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView3.image = image
                    self?.statusLabel3.text = "Image Loaded Successfully"
                } else if let error = error {
                    self?.statusLabel3.text = error.localizedDescription
                }
            }
        }

        statusLabel4.text = "Starting loading"
        let _ = fireManager.fetch(with: url) { [weak self] (image, url, error) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView4.image = image
                    self?.statusLabel4.text = "Image Loaded Successfully"
                } else if let error = error {
                    self?.statusLabel4.text = error.localizedDescription
                }
            }
        }

        statusLabel5.text = "Starting loading"
        let _ = fireManager.fetch(with: url) { [weak self] (image, url, error) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView5.image = image
                    self?.statusLabel5.text = "Image Loaded Successfully"
                } else if let error = error {
                    self?.statusLabel5.text = error.localizedDescription
                }
            }
        }
        
        task3?.cancel()
    }
}
