//
//  CommentsVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SDWebImage
//import Appodeal

class CommentsVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var post: PostModel!
    
    private var comments = [CommentModel]()
    private var profiles = [ProfileModel]()
    private var groups = [GroupModel]()
    
    private var offset = 0
    private var isEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Комментарии"
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        tableView.register(UINib(nibName: "CommentCell", bundle: SocialCatalystSDK.getBundle()), forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()

        loadData()
        
        if SocialCatalystSDK.shared.isEnabledAdsForPage(.comments) {
//            Appodeal.showAd(.bannerBottom, rootViewController: self)
        }
    }
    
    @objc func refreshData() {
        isEnd = false
        loadData(offset: 0)
    }
    
    @objc func loadData(offset: Int = 0) {
        if !isEnd {
            VKManager.getCommentsForPost(id: post.id, offset: offset, success: { (comments) in
                if offset == 0 {
                    self.comments = comments.items
                    self.profiles = comments.profiles ?? [ProfileModel]()
                    self.groups = comments.groups ?? [GroupModel]()
                } else {
                    self.comments.append(contentsOf: comments.items)
                    self.profiles.append(contentsOf: comments.profiles ?? [ProfileModel]())
                    self.groups.append(contentsOf: comments.groups ?? [GroupModel]())
                }
                self.title = "Комментарии: (\(comments.count ?? 0))"
                if comments.items.count != 0 {
                    self.tableView.reloadData()
                } else {
                    self.isEnd = true
                }
                self.refreshControl.endRefreshing()
            }) { (error) in
                self.refreshControl.endRefreshing()
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
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
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CommentCell
        cell.commentTextLabel.text = comment.text
        cell.dateLabel.text = DateManager.convertDate(unixTime: comment.date)
        cell.likeButton.setTitle("\(comment.likes?.count ?? 0)", for: .normal)
        if let likes = comment.likes, let isLike = likes.userLikes, isLike {
            cell.likeButton.setImage(UIImage(named: "Combined Shape", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "outline-heart", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), for: .normal)
        }
        if comment.fromId < 0 {
            let group = DataModelManager.findGroupInArrayById(comment.fromId, groups: groups)
            cell.userNameLabel.text = group?.name
            if let photo = group?.photo100 {
                cell.userPictureImageView.sd_setImage(with: URL(string: photo), completed: nil)
            }
        } else {
            if let profile = DataModelManager.findUserInArrayById(comment.fromId, users: profiles) {
                cell.userNameLabel.text = "\(profile.firstName ?? "") \(profile.secondName ?? "")"
                if let photo = profile.photo100 {
                    cell.userPictureImageView.sd_setImage(with: URL(string: photo), completed: nil)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
