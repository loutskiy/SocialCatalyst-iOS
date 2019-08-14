//
//  PreviewModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PreviewModel {
    var photo: ImageModel?
    var graffiti: ImageModel?
    var audioMessage: AudioMessageModel?
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        photo <- map["photo"]
        graffiti <- map["graffiti"]
        audioMessage <- map["audio_msg"]
    }
}
