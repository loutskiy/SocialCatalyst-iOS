//
//  NewsVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 02/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SDWebImage
//import Appodeal
import GoogleMobileAds

class NewsVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    private var news = [PostModel]()
    private var offset = 0
    private var isEnd = false
    let newView = GADBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = SocialCatalystSDK.shared.getSettings().feedTitleName
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(UINib(nibName: "PostCell", bundle: SocialCatalystSDK.getBundle()), forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        loadData()
        
        if SocialCatalystSDK.shared.isEnabledAdsForPage(.feed) {
//            Appodeal.showAd(.bannerBottom, forPlacement: "FEED", rootViewController: self)
//            self.tableView.tableFooterView = newView
            self.tableView.tableHeaderView = newView
            newView.adUnitID = "ca-app-pub-8849088710729196/5147472672"
            newView.rootViewController = self
            newView.load(GADRequest())
            newView.backgroundColor = .white
            newView.frame.size.height = 60
            newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            newView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            newView.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            newView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
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
//                print(posts)
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
            cell.bookmarkButton.setImage(UIImage(named: "Bookmark Icon Pressed", in: SocialCatalystSDK.getBundle(),  compatibleWith: nil), for: .normal)
        } else {
            cell.bookmarkButton.setImage(UIImage(named: "Bookmark Icon", in: SocialCatalystSDK.getBundle(),  compatibleWith: nil), for: .normal)
        }
        if let image = DataModelManager.getPhotoFromAttachments(currentPost.attachments) {
            cell.postImageView.sd_setImage(with: URL(string: image), completed: nil)
        } else {
            cell.postImageView.image = UIImage(named: "placeholder", in: SocialCatalystSDK.getBundle(),  compatibleWith: nil)
        }
        if let likes = post.likes, let isLike = likes.userLikes, isLike {
            cell.likeButton.setImage(UIImage(named: "Combined Shape", in: SocialCatalystSDK.getBundle(),  compatibleWith: nil), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "outline-heart", in: SocialCatalystSDK.getBundle(),  compatibleWith: nil), for: .normal)
        }
        cell.commentsButton.isHidden = SocialCatalystSDK.shared.getSettings().availableComments ? false : true
        cell.likeButton.isHidden = SocialCatalystSDK.shared.getSettings().availableLikes ? false : true
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = news[indexPath.row]
        let currentPost = DataModelManager.getCurrentPostModelFromPost(post)
        if SocialCatalystSDK.shared.getSettings().postViewMode == PostTypes.readingMode || SocialCatalystSDK.shared.getSettings().postViewMode == PostTypes.webMode || SocialCatalystSDK.shared.getSettings().postViewMode == PostTypes.customJSRulesMode, let link = DataModelManager.getLinkFromAttachments(currentPost.attachments) {
            let vc = PFWebViewController(urlString: link.url)
            vc!.textFromLink = link.description
            vc!.titleFromLink = link.title
            vc!.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc!, animated: true)
        } else if SocialCatalystSDK.shared.getSettings().postViewMode != PostTypes.disable && SocialCatalystSDK.shared.getSettings().availablePostView {
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
                cell.bookmarkButton.setImage(UIImage(named: "Bookmark Icon Pressed", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "Bookmark Icon", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), for: .normal)
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
