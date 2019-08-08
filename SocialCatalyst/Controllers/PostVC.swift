//
//  PostVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SDWebImage
import Appodeal

class PostVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var post: PostModel!
    var attachments = [AttachmentModel]()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Запись"
        setUIFromPost()
        
        if ConfigurationManager.shared.isEnabledAdsForPage(.post) {
            Appodeal.showAd(.bannerBottom, rootViewController: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
        }
    }
    
    func setUIFromPost() {
        if post != nil {
            let realPost = DataModelManager.getCurrentPostModelFromPost(post)
            postDateLabel.text = DateManager.convertDate(unixTime: realPost.date)
            postTextView.text = realPost.text
            commentsButton.setTitle("\(post.comments.count ?? 0)", for: .normal)
            likeButton.setTitle("\(post.likes.count ?? 0)", for: .normal)
            commentsButton.isHidden = ConfigurationManager.shared.configApiVK.availableComments ? false : true
            likeButton.isHidden = ConfigurationManager.shared.configApiVK.availableLikes ? false : true
            setBookmarkButton()
            
            if let userId = realPost.ownerId {
                if userId < 0 {
                    VKManager.getGroupInfo(groupId: userId, success: { (group) in
                        self.authorNameLabel.text = group.name
                        self.avatarImageView.sd_setImage(with: URL(string: group.photo_100), completed: nil)
                    }) { (error) in
                        self.showAlert(title: "Ошибка", message: error.localizedDescription)
                    }
                } else {
                    VKManager.getUserById(userId, success: { user in
                        self.authorNameLabel.text = "\(user.first_name ?? "") \(user.last_name ?? "")"
                        self.avatarImageView.sd_setImage(with: URL(string: user.photo_100), completed: nil)
                    }, fail: { error in
                        self.showAlert(title: "Ошибка", message: error.localizedDescription)
                    })
                }
            }
        }
    }
    
    func setBookmarkButton() {
        if CoreDataManager.haveInFavourite(postId: post.id) {
            let bookmarkButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Bookmark Icon Pressed"), style: .done, target: self, action: #selector(addToBookmark))
            navigationItem.rightBarButtonItem = bookmarkButton
        } else {
            let bookmarkButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Bookmark Icon"), style: .done, target: self, action: #selector(addToBookmark))
            navigationItem.rightBarButtonItem = bookmarkButton
        }
    }
    
    @objc func addToBookmark() {
        CoreDataManager.addToFavourite(postId: post.id)
        setBookmarkButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    @IBAction func commentsAction(_ sender: Any) {
        openComments(for: post)
    }
    
    @IBAction func likeAction(_ sender: Any) {
    }
    
    @IBAction func shareAction(_ sender: Any) {
        showShare(for: post, sourceView: shareButton)
    }
}

extension PostVC: UITextViewDelegate {
    
}
