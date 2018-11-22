//
//  PasteBinListVC+Delegates.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

extension PasteBinListVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        
        if bottomEdge >= scrollView.contentSize.height {    //We reached bottom
            loadPosts()
        }
    }
}

extension PasteBinListVC: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PostCell
        
        let infoObj = postsArray[indexPath.row]
        
        cell?.nameLabel?.text = infoObj.name
        cell?.userIconImageView.setImage(with: infoObj.userIconURL, placeholder: #imageLiteral(resourceName: "fire-placeholder"))
        cell?.postImageView.setImage(with: infoObj.postImageURL, placeholder: #imageLiteral(resourceName: "big-placeholder"))
        cell?.likesCountLabel?.text = infoObj.totalLikes
        cell?.likeButton.isSelected = infoObj.isLikedByUser
        cell?.postImageView.backgroundColor = infoObj.color
        
        cell?.likeActionBlock = { isLiked in
            //1. Update on server
            //2. If success, refresh `pagingViewModel`
            //3. Reload `postCollectionView` or just reload this `cell`
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDataSourcePrefetching

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        let urls = indexPaths.compactMap { indexPath in postsArray[indexPath.row].postImageURL }
        
        urls.forEach { url in
            FireImageManager.shared.fetch(with: url)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .carPlay, .tv, .unspecified:
            fallthrough
        case .phone:
            return CGSize(width: collectionView.frame.width, height: cellHeight)
        case .pad:
            
            let screenWidth = UIScreen.main.bounds.width
            
            let collectionViewWidth = collectionView.bounds.width

            let isMoreThanHalfOfScreen = collectionViewWidth > (screenWidth/2)
            
            let numberOfColumns: CGFloat = isMoreThanHalfOfScreen ? 2 : 1

            return CGSize(width: collectionView.frame.width/numberOfColumns, height: cellHeight)
        }
    }
}
