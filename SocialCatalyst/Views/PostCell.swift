//
//  PostCell.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 02/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol PostCellDelegate: NSObject {
    func clickToShareButton(for cell: PostCell)
    func clickToFavouriteButton(for cell: PostCell)
    func clickToCommentsButton(for cell: PostCell)
    func clickToLikeButton(for cell: PostCell)
}

extension PostCellDelegate {
    func clickToShareButton(for cell: PostCell) {}
    func clickToFavouriteButton(for cell: PostCell) {}
    func clickToCommentsButton(for cell: PostCell) {}
    func clickToLikeButton(for cell: PostCell) {}
}

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    weak var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func commentsAction(_ sender: Any) {
        delegate?.clickToCommentsButton(for: self)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        delegate?.clickToLikeButton(for: self)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        delegate?.clickToShareButton(for: self)
    }
    
    @IBAction func bookmarkAction(_ sender: Any) {
        delegate?.clickToFavouriteButton(for: self)
    }
}
