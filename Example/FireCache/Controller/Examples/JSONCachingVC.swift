//
//  JSONCachingVC.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

///
/// This class demonstrate point 2 from Challenge.pdf's requirement section.
///
/// The same image may be requested by multiple sources simultaneously (even before it has loaded),
/// And if one of the sources cancels the load, it should not affect the remaining requests;
///
/// Here we are make 5 request for same URL, and cancelling task number 3, won't affect rest 4 tasks.
///

class JSONCachingVC: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var responseArrayTextView: UITextView!

    @IBOutlet weak var arrayLoadingTimeLabel: UILabel!

    @IBOutlet weak var responseDictionaryTextView: UITextView!

    @IBOutlet weak var dictionaryLoadingTimeLabel: UILabel!

    // MARK: - CacheManager
    
    let fireManager = FireManager<JSON>()
    
    let arrayJSONURL = "https://pastebin.com/raw/wgkJgazE"              //returns array JSON

    let dictionaryJSONURL = "https://api.plos.org/search?q=title:DNA"         //returns dictionary JSON

    // MARK: - IBOutlets Actions
    
    @IBAction func loadArrayJSONAction(_ sender: Any) {
        
        guard let url = URL(string: arrayJSONURL) else { return }

        responseArrayTextView.text = nil
        arrayLoadingTimeLabel.text = nil

        let dateStarted = Date()
        
        fireManager.fetch(with: url) { [weak self] (json, _, error) in
            DispatchQueue.main.async {
                let seconds = Date().timeIntervalSince(dateStarted)
                self?.arrayLoadingTimeLabel.text = "\(seconds) seconds"
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
        
        responseDictionaryTextView.text = nil
        dictionaryLoadingTimeLabel.text = nil

        let dateStarted = Date()

        fireManager.fetch(with: url) { [weak self] (json, _, error) in
            DispatchQueue.main.async {
                let seconds = Date().timeIntervalSince(dateStarted)
                self?.dictionaryLoadingTimeLabel.text = "\(seconds) seconds"
                if let json = json {
                    self?.responseDictionaryTextView.text = json.dictionary?.description ?? "No dictionary returned."
                } else if let error = error {
                    self?.responseDictionaryTextView.text = error.localizedDescription
                }
            }
        }
    }
}
