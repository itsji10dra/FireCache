//
//  CacheExpiryVC.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

///
/// This class demonstrate point 3 from Challenge.pdf's requirement section.
///
/// The cache should have a configurable max capacity and should evict images not recently used;
///

class CacheExpiryVC: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var responseTextView: UITextView!
    
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var timerTextView: UITextView!

    // MARK: - CacheManager
    
    var timer: Timer!
    
    let fireManager = FireManager<String>()
    
    let url = "https://pastebin.com/raw/B75vJCLX"       //A string returning url
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cache Maximum Size
        fireManager.cache.maximumSize = 100
        
        //Cache life
        fireManager.cache.cacheLifeSpan = 20
        fireManager.cache.expiryCheckTimeInterval = 60
        
        guard let url = URL(string: url) else { return }
        
        statusLabel.text = "Starting Download..."
        
        fireManager.fetch(with: url) { [weak self] (string, _, error) in
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                if let string = string {
                    weakSelf.responseTextView.text = string
                    weakSelf.statusLabel.text = "String Loaded Successfully"
                    weakSelf.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                          target: weakSelf,
                                                          selector: #selector(weakSelf.checkCacheExpiry),
                                                          userInfo: nil,
                                                          repeats: true)
                } else if let error = error {
                    weakSelf.statusLabel.text = error.localizedDescription
                }
            }
        }
    }
    
    deinit {
        timer.invalidate()
    }
    
    var counter: Int = 0
    
    @objc
    func checkCacheExpiry() {
        
        let text = timerTextView.text ?? ""
        
        let cacheExist = fireManager.cache.contains(forKey: url)
        
        let newText = "\(counter) seconds passed. \(cacheExist ? "Object still cached." : "Not cached any more.")"
        
        timerTextView.text = newText + "\n" + text
        
        counter += 1
    }
}
