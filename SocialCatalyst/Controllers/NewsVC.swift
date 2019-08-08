//
//  NewsVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 02/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SDWebImage
import Appodeal

class NewsVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    private var news = [PostModel]()
    private var offset = 0
    private var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ConfigurationManager.shared.configApiVK.feedTitleName
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        loadData()
        
        if ConfigurationManager.shared.isEnabledAdsForPage(.feed) {
            Appodeal.showAd(.bannerBottom, rootViewController: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc func refreshData() {
        isEnd = false
        loadData(offset: 0)
    }
    
    func loadData(offset: Int = 0) {
        print(offset)
        if !isEnd {
            VKManager.getWall(offset: offset, success: { (posts) in
                if offset == 0 {
                    self.news = posts.items
                } else {
                    self.news.append(contentsOf: posts.items)
                }
                if posts.items.count != 0 {
                    self.tableView.reloadData()
                } else {
                    self.isEnd = true
                }
                self.refreshControl.endRefreshing()
                print(posts)
            }) { (error) in
                self.refreshControl.endRefreshing()
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
                print(error)
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height * 2 {
            offset = offset + 20
            loadData(offset: offset)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = news[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PostCell
        let currentPost = DataModelManager.getCurrentPostModelFromPost(post)
        cell.titleLabel.text = currentPost.text.removingUrls()
        cell.dateLabel.text = DateManager.convertDate(unixTime: post.date)
        cell.commentsButton.setTitle("\(post.comments.count ?? 0)", for: .normal)
        cell.likeButton.setTitle("\(post.likes.count ?? 0)", for: .normal)
        cell.delegate = self
        if CoreDataManager.haveInFavourite(postId: post.id) {
            cell.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark Icon Pressed"), for: .normal)
        } else {
            cell.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark Icon"), for: .normal)
        }
        if let image = DataModelManager.getPhotoFromAttachments(currentPost.attachments) {
            cell.postImageView.sd_setImage(with: URL(string: image), completed: nil)
        } else {
            cell.postImageView.image = #imageLiteral(resourceName: "placeholder")
        }
        if let likes = post.likes, let isLike = likes.userLikes, isLike {
            cell.likeButton.setImage(#imageLiteral(resourceName: "Combined Shape"), for: .normal)
        } else {
            cell.likeButton.setImage(#imageLiteral(resourceName: "outline-heart"), for: .normal)
        }
        cell.commentsButton.isHidden = ConfigurationManager.shared.configApiVK.availableComments ? false : true
        cell.likeButton.isHidden = ConfigurationManager.shared.configApiVK.availableLikes ? false : true
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = news[indexPath.row]
        let currentPost = DataModelManager.getCurrentPostModelFromPost(post)
        if ConfigurationManager.shared.configApiVK.postViewMode == PostTypes.readingMode || ConfigurationManager.shared.configApiVK.postViewMode == PostTypes.webMode || ConfigurationManager.shared.configApiVK.postViewMode == PostTypes.customJSRulesMode, let link = DataModelManager.getLinkFromAttachments(currentPost.attachments) {
            let vc = PFWebViewController(urlString: link.url)
            vc!.textFromLink = link.description
            vc!.titleFromLink = link.title
            vc!.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc!, animated: true)
        } else if ConfigurationManager.shared.configApiVK.postViewMode != PostTypes.disable && ConfigurationManager.shared.configApiVK.availablePostView {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
            vc.post = post
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewsVC: PostCellDelegate {
    func clickToFavouriteButton(for cell: PostCell) {
        let indexPath = tableView.indexPath(for: cell)
        if let indexPath = indexPath {
            let post = news[indexPath.row]
            CoreDataManager.addToFavourite(postId: post.id)
            if CoreDataManager.haveInFavourite(postId: post.id) {
                cell.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark Icon Pressed"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark Icon"), for: .normal)
            }
        }
    }
    
    func clickToShareButton(for cell: PostCell) {
        let indexPath = tableView.indexPath(for: cell)
        if let indexPath = indexPath {
            let post = news[indexPath.row]
            showShare(for: post, sourceView: cell.shareButton)
        }
    }
    
    func clickToCommentsButton(for cell: PostCell) {
        let indexPath = tableView.indexPath(for: cell)
        if let indexPath = indexPath {
            let post = news[indexPath.row]
            openComments(for: post)
        }
    }
    
}
