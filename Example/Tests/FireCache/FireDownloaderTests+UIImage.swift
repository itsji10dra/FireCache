//
//  FireDownloaderTests+UIImage.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

extension FireDownloaderTests {
    
    func testDownloadImage() {
        let expectation = self.expectation(description: "Wait for downloading image")
        
        _ = imageDownloader.downloadObject(with: imageURL) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
            
        _ = imageDownloader.downloadObject(with: errorURL) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringUsingImageDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = imageDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONUsingImageDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
                
        _ = imageDownloader.downloadObject(with: jsonURL) { (json, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
}

