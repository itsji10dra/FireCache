//
//  PostTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
@testable import FireCache_Example

class PostTests: XCTestCase {

    // MARK: - Decoding

    func testJSONDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "Post", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }
        
        do {
            let post = try JSONDecoder().decode(Post.self, from: data)
            XCTAssertEqual(post.id, "4kQA1aQK8-Y")
            XCTAssertEqual(post.color, "#060607")
            XCTAssertEqual(post.likes, 12)
            XCTAssertFalse(post.likedByUser)
            XCTAssertNotNil(post.user)
            XCTAssertNotNil(post.images.raw.absoluteString, "https://www.raw.com")
            XCTAssertNotNil(post.images.full.absoluteString, "https://www.full.com")
            XCTAssertNotNil(post.images.regular.absoluteString, "https://www.regular.com")
            XCTAssertNotNil(post.images.small.absoluteString, "https://www.small.com")
            XCTAssertNotNil(post.images.thumb.absoluteString, "https://www.thumb.com")
        } catch {
            XCTFail("JSON Decoding for class \(Post.self) failed.")
        }
    }
}
