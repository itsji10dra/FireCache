//
//  ViewController.swift
//  FireCache
//
//  Created by Jitendra on 11/16/2018.
//  Copyright (c) 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://pastebin.com/raw/wgkJgazE") else { return }
        
        FireJSONManager.shared.fetch(with: url) { [weak self] (json, url) in
            print(json)
        }
    }
}

