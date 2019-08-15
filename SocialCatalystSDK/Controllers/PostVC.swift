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
    
    var currentIndexPathRow = -1
    
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
        
        tableView.register(UINib(nibName: "AudioAttachmentCell", bundle: SocialCatalystSDK.getBundle()), forCellReuseIdentifier: "AudioAttachmentCell")
        tableView.register(UINib(nibName: "MediaAttachmentCell", bundle: SocialCatalystSDK.getBundle()), forCellReuseIdentifier: "MediaAttachmentCell")
        tableView.register(UINib(nibName: "LinkAttachmentCell", bundle: SocialCatalystSDK.getBundle()), forCellReuseIdentifier: "LinkAttachmentCell")
        
        setUIFromPost()
        
        if SocialCatalystSDK.shared.isEnabledAdsForPage(.post) {
            Appodeal.showAd(.bannerBottom, forPlacement: "POST", rootViewController: self)
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
            commentsButton.isHidden = SocialCatalystSDK.shared.getSettings().availableComments ? false : true
            likeButton.isHidden = SocialCatalystSDK.shared.getSettings().availableLikes ? false : true
            attachments = realPost.attachments ?? [AttachmentModel]()
            tableView.reloadData()
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
            let bookmarkButton = UIBarButtonItem(image:UIImage(named: "Bookmark Icon Pressed", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), style: .done, target: self, action: #selector(addToBookmark))
            navigationItem.rightBarButtonItem = bookmarkButton
        } else {
            let bookmarkButton = UIBarButtonItem(image:UIImage(named: "Bookmark Icon", in: SocialCatalystSDK.getBundle(), compatibleWith: nil), style: .done, target: self, action: #selector(addToBookmark))
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
        let attachment = attachments[indexPath.row]
        if let type = attachment.type {
            switch type {
            case .photo:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MediaAttachmentCell") as! MediaAttachmentCell
                cell.contentTypeImageView.image = UIImage(named: "photo_attach", in: SocialCatalystSDK.getBundle(), compatibleWith: nil)
                cell.previewImageView.sd_setImage(with: URL(string: DataModelManager.getBestQualityPhotoFromObject(attachment.photo!)!), completed: nil)
                return cell
            case .postedPhoto:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MediaAttachmentCell") as! MediaAttachmentCell
                cell.contentTypeImageView.image = UIImage(named: "photo_attach", in: SocialCatalystSDK.getBundle(), compatibleWith: nil)
                cell.previewImageView.sd_setImage(with: URL(string: attachment.postedPhoto!.photo604), completed: nil)
                return cell
            case .video:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MediaAttachmentCell") as! MediaAttachmentCell
                cell.contentTypeImageView.image = UIImage(named: "film_attach", in: SocialCatalystSDK.getBundle(), compatibleWith: nil)
                cell.previewImageView.sd_setImage(with: URL(string: DataModelManager.getBestQualityPhotoFromVideoObject(attachment.video!)!), completed: nil)
                return cell
            case .audio:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AudioAttachmentCell") as! AudioAttachmentCell
                cell.trackNameLabel.text = attachment.audio!.title
                cell.trackAuthorLabel.text = attachment.audio!.artist
                cell.durationLabel.text = attachment.audio!.duration.toAudioString
                return cell
            case .doc:
                break
            case .graffiti:
                break
            case .link:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LinkAttachmentCell") as! LinkAttachmentCell
                cell.linkTitleLabel.text = attachment.link!.title
                cell.siteUrlLabel.text = attachment.link!.url
                return cell
            case .note:
                break
            case .app:
                break
            case .poll:
                break
            case .page:
                break
            case .album:
                break
            case .photosList:
                break
            case .market:
                break
            case .marketAlbum:
                break
            case .sticker:
                break
            case .prettyCards:
                break
            case .event:
                break
            case .unknown:
                let cell = UITableViewCell()
                return cell
            }
        } else {
            let cell = UITableViewCell()
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attachment = attachments[indexPath.row]
        if let type = attachment.type {
            switch type {
            case .photo:
                break
            case .postedPhoto:
                break
            case .video:
                VKManager.getVideo(attachment.video!, success: {
                    video in
                }, fail: {
                    error in
                    print(error.localizedDescription)
                })
                print(attachment.video?.toJSONString())
                break
            case .audio:
                if currentIndexPathRow != indexPath.row {
                    currentIndexPathRow = indexPath.row
                    let song : AudioModel = attachment.audio!
                    
                    updateCurrentTrackInfo()
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    //            let fileURL = documentsURL.appendingPathComponent("\(song.id)_\(song.ownerId).mp3")
                    let sourceURL = URL(string:song.url)
                    print(sourceURL)
                    DispatchQueue.global(qos: .background).async {
                        AudioPlayer.defaultPlayer.playAudio(fromURL: sourceURL)
                    }
                    
                    let player = self.storyboard?.instantiateViewController(withIdentifier: "MusicPlayerVC") as! MusicPlayerVC
                    
                    player.albumArt = UIImage(named: "AlbumPlaceholder", in: SocialCatalystSDK.getBundle(), compatibleWith: nil)!
                    player.songTitle = song.title
                    player.albumTitle = song.artist
                    player.popupItem.progress = 0
                    
                    VKManager.sendRequestToLastFM(artist: song.artist, track: song.title, success: { (path) in
                        SDWebImageDownloader.shared.downloadImage(with: URL(string: path), options: [], progress: nil, completed: { (image, data, error, _) in
                            player.albumArt = image!
                        })
                    }) { (error) in
                        self.showAlert(title: "Ошибка", message: error.localizedDescription)
                    }
                    
                    tabBarController?.presentPopupBar(withContentViewController: player, animated: true, completion: nil)
                    tabBarController?.popupBar.tintColor = SocialCatalystSDK.shared.getColorAppearance().mainColor
                    tabBarController?.popupBar.imageView.layer.cornerRadius = 5
                    tabBarController?.popupBar.progressViewStyle = .top
                    
                }
            case .doc:
                break
            case .graffiti:
                break
            case .link:
                break
            case .note:
                break
            case .app:
                break
            case .poll:
                break
            case .page:
                break
            case .album:
                break
            case .photosList:
                break
            case .market:
                break
            case .marketAlbum:
                break
            case .sticker:
                break
            case .prettyCards:
                break
            case .event:
                break
            case .unknown:
                break
            }
        }
    }
    
    func updateCurrentTrackInfo() {
        AudioPlayer.defaultPlayer.setPlayList(DataModelManager.filterAttachmentsArrayForAudio(attachments))
        AudioPlayer.index = currentIndexPathRow
        
        NotificationCenter.default.post(name: .playTrackAtIndex, object: nil, userInfo: ["index" : currentIndexPathRow])
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
