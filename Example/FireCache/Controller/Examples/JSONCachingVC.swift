//
//  JSONCachingVC.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

class JSONCachingVC: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var responseArrayTextView: UITextView!

    @IBOutlet weak var responseDictionaryTextView: UITextView!

    // MARK: - CacheManager
    
    let fireManager = FireManager<JSON>()
    
    let arrayJSONURL = "https://pastebin.com/raw/wgkJgazE"              //returns array JSON

    let dictionaryJSONURL = "https://api.plos.org/search?q=title:DNA"         //returns dictionary JSON

    // MARK: - IBOutlets Actions
    
    @IBAction func loadArrayJSONAction(_ sender: Any) {
        
        guard let url = URL(string: arrayJSONURL) else { return }

        fireManager.fetch(with: url) { [weak self] (json, _, error) in
            DispatchQueue.main.async {
                if let json = json {
                    self?.responseArrayTextView.text = json.array?.description ?? "No array returned."
                } else if let error = error {
                    self?.responseArrayTextView.text = error.localizedDescription
                }
            }
        }
    }
    
    @IBAction func loadDictionaryJSONAction(_ sender: Any) {
        
        guard let url = URL(string: dictionaryJSONURL) else { return }
        
        fireManager.fetch(with: url) { [weak self] (json, _, error) in
            DispatchQueue.main.async {
                if let json = json {
                    self?.responseDictionaryTextView.text = json.dictionary?.description ?? "No dictionary returned."
                } else if let error = error {
                    self?.responseDictionaryTextView.text = error.localizedDescription
                }
            }
        }
    }
}
