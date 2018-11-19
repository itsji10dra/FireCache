//
//  ViewController.swift
//  FireCache
//
//  Created by Jitendra on 11/16/2018.
//  Copyright (c) 2018 itsji10dra.com. All rights reserved.
//

import UIKit
import FireCache

class PasteBinListVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    @IBOutlet weak var loaderView: LoadingView!

    // MARK: - Data

    struct ListDisplayModel {
        let name: String
        let userIconURL: URL
        let postImageURL: URL
        let totalLikes: String
        let isLikedByUser: Bool
    }
    
    internal let cellIdentifier = "PostCell"
    
    internal lazy var postsArray: [ListDisplayModel] = []
    
    internal var pagingModel: PagingViewModel<Post, ListDisplayModel>!

    // MARK: - View Hierarchy

    override func viewDidLoad() {
        super.viewDidLoad()

        pagingModel = PagingViewModel<Post, ListDisplayModel>(endPoint: .posts,
                                                              transform: { result -> [ListDisplayModel] in
            return result.map { ListDisplayModel(name: $0.user.name,
                                                 userIconURL: $0.user.profileImages.small,
                                                 postImageURL: $0.images.regular,
                                                 totalLikes: String($0.likes),
                                                 isLikedByUser: $0.likedByUser ) }
        })
        
        loadPosts()
    }
    
    deinit {
        pagingModel.clearDataSource()
    }
    
    // MARK: - Loader Method

    internal func loadPosts() {
        
        let handler: PagingViewModel<Post, ListDisplayModel>.PagingDataResult = { [weak self] (data, error, page) in
            
            ActivityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                if let data = data {
                    self?.postsArray = data
                    self?.postCollectionView.reloadData()
                    self?.loaderView.hide()
                } else if let error = error {
                    if page == 0 {
                        self?.showErrorAlert(with: error.localizedDescription)
                    } else {
                        self?.loaderView.showMessage("Error loading data.", animateLoader: false, autoHide: 5.0)
                    }
                }
            }
        }
        
        let loadingInfo = pagingModel.loadMoreData(handler: handler)
        
        if loadingInfo.isLoading {
            if loadingInfo.page == 0 {
                ActivityIndicator.startAnimating()
            } else {
                loaderView.showMessage("Loading...", animateLoader: true)
            }
        } else {
            loaderView.hide()
        }
    }
    
    // MARK: - Alerts
    
    private func showErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadPosts()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

