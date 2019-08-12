//
//  LinkAttachmentCell.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 12/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

class LinkAttachmentCell: UITableViewCell {

    @IBOutlet weak var linkTitleLabel: UILabel!
    @IBOutlet weak var siteUrlLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
