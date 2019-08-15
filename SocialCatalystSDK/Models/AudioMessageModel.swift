//
//  AudioMessageModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AudioMessageModel: Mappable {
    var duration: Int?
    var waveform: [Int]?
    var linkOgg: String?
    var linkMp3: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        duration <- map["duration"]
        waveform <- map["waveform"]
        linkOgg <- map["link_ogg"]
        linkMp3 <- map["link_mp3"]
    }
}
