//
//  CommentCell.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: NSObject {
    func didClickOnLike(for cell: CommentCell)
}

extension CommentCellDelegate {
    func didClickOnLike(for cell: CommentCell) {}
}

class CommentCell: UITableViewCell {

    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: CommentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeAction(_ sender: Any) {
        delegate?.didClickOnLike(for: self)
    }
}
