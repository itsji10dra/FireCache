//
//  FireCacheTests+JSON.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

extension FireCacheTests {
    
    func testStoreJSONObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving JSON")
        
        let key = "Key1"
        let stringJSON = """
{
    "name":"John",
    "age":30,
    "cars": [
        { "name":"Ford", "models":[ "Fiesta", "Focus", "Mustang" ] },
        { "name":"BMW", "models":[ "320", "X3", "X5" ] },
        { "name":"Fiat", "models":[ "500", "Panda" ] }
    ]
 }
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }
        
        jsonCache.storeObject(json, forKey: key) {
            let cachedJSON = self.jsonCache.retrieveObject(forKey: key)
            XCTAssertNotNil(cachedJSON)
            XCTAssertNotNil(cachedJSON?.dictionary)
            XCTAssertNil(cachedJSON?.array)
            XCTAssertEqual((cachedJSON?.dictionary?["cars"] as? [AnyObject])?.count, 3)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testRemoveJSONObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving JSON")
        
        let key = "Key2"
        let stringJSON = """
{
    "fruit": "Apple",
    "size": "Large",
    "color": "Red"
}
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }
        
        jsonCache.storeObject(json, forKey: key)
        jsonCache.removeObject(forKey: key) {
            let cachedJSON = self.jsonCache.retrieveObject(forKey: key)
            XCTAssertNil(cachedJSON)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testContainsJSONObject() {
        
        let key = "Key3"
        let stringJSON = """
{
    "greeting":"hello"
}
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }
        
        jsonCache.storeObject(json, forKey: key)
        XCTAssertTrue(jsonCache.containsObject(forKey: key))
    }
}
