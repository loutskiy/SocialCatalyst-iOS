//
//  AudioAttachmentCell.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 12/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol AudioAttachmentCellDelegate: NSObject {
    func didClickToPlayPauseButton()
}

class AudioAttachmentCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackAuthorLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    weak var delegate: AudioAttachmentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.imageView?.tintColor = SocialCatalystSDK.shared.getColorAppearance().mainColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickToButtonAction(_ sender: Any) {
    }
}
