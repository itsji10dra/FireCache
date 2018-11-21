//
//  UserTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
@testable import FireCache_Example

class UserTests: XCTestCase {

    // MARK: - Decoding
    
    func testJSONDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "User", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            XCTAssertEqual(user.id, "OevW4fja2No")
            XCTAssertEqual(user.username, "nicholaskampouris")
            XCTAssertEqual(user.name, "Nicholas Kampouris")
            XCTAssertEqual(user.profileImage.small.absoluteString, "https://small.profileimage.com")
            XCTAssertEqual(user.profileImage.medium.absoluteString, "https://medium.profileimage.com")
            XCTAssertEqual(user.profileImage.large.absoluteString, "https://large.profileimage.com")

        } catch {
            XCTFail("JSON Decoding for class \(User.self) failed.")
        }
    }
}
