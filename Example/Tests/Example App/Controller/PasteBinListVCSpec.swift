//
//  PasteBinListVCSpec.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 22/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Quick
import Nimble
@testable import FireCache_Example

class PasteBinListVCSpec: QuickSpec {

    typealias Model = PasteBinListVC.ListDisplayModel

    override func spec() {
        describe("PasteBinListVCSpec") {
            var pasteBinListVC: PasteBinListVC?
            
            beforeEach {
                let models: [Model] = [Model(name: "Name 1",
                                             userIconURL: URL(string: "http://user.icon.1.com")!,
                                             postImageURL: URL(string: "http://post.image.1.com")!,
                                             totalLikes: "5 likes",
                                             isLikedByUser: false,
                                             color: UIColor.orange),
                                       Model(name: "Name 2",
                                             userIconURL: URL(string: "http://user.icon.2.com")!,
                                             postImageURL: URL(string: "http://post.image.3.com")!,
                                             totalLikes: "8 likes",
                                             isLikedByUser: true,
                                             color: UIColor.purple)]
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pasteBinListVC = storyboard.instantiateViewController(withIdentifier: "PasteBinList") as? PasteBinListVC
                pasteBinListVC?.postsArray = models
                _ = pasteBinListVC?.view
            }
            
            context("when view is loaded") {
                it("should have 1 section") {
                    let collectionView = pasteBinListVC?.postCollectionView
                    
                    let sections = collectionView?.numberOfSections
                    expect(sections).to(equal(1))
                    
                    expect(collectionView?.numberOfItems(inSection: 2)).to(raiseException())
                }
                
                it("should have 2 items in first section") {
                    let collectionView = pasteBinListVC?.postCollectionView
                    
                    let section0Count = collectionView?.numberOfItems(inSection: 0)
                    expect(section0Count).to(equal(2))
                }
            }
        }
    }
}
