//
//  AttachmentModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum AttachmentType: String {
    case photo = "photo"
    case postedPhoto = "posted_photo"
    case video = "video"
    case audio = "audio"
    case doc = "doc"
    case graffiti = "graffiti"
    case link = "link"
    case note = "note"
    case app = "app"
    case poll = "poll"
    case page = "page"
    case album = "album"
    case photosList = "photos_list"
    case market = "market"
    case marketAlbum = "market_album"
    case sticker = "sticker"
    case prettyCards = "pretty_cards"
    case event = "event"
    case unknown
}

class AttachmentModel: Mappable {
    var type: AttachmentType!
    var photo: PhotoModel?
    var postedPhoto: PostedPhotoModel?
    var video: VideoModel?
    var audio: AudioModel?
    var doc: DocumentModel?
    var graffiti: GraffitiModel?
    var link: LinkModel?
    var note: NoteModel?
    var app: AppModel?
    var poll: PollModel?
    var page: PageModel?
    var album: AlbumModel?
    var photosList: [Int]?
    var market: MarketItemModel?
    var marketAlbum: MarketAlbumModel?
    var sticker: StickerModel?
    var prettyCards: PrettyCardsModel?
    var event: EventModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- (map["type"], JSONStringToAttachmentTypeTransform())
        photo <- map["photo"]
        link <- map["link"]
    }
}

