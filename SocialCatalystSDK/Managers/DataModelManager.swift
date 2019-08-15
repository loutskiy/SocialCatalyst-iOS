//
//  DataModelManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class DataModelManager {
    
    
    /// Finding a link to photo in attachment object, priority object from PhotoModel
    ///
    /// - Parameter attachments: array with Attachment models
    /// - Returns: String or nil if nothing founded
    class func getPhotoFromAttachments(_ attachments: [AttachmentModel]?) -> String? {
        var image: String?
        if let attachments = attachments {
            for attach in attachments {
                if let type = attach.type {
                    if type == .link, let link = attach.link, image == nil || image == "", let photo = link.photo {
                        image = getBestQualityPhotoFromObject(photo)
                    } else if type == .video, let video = attach.video {
                        image = getBestQualityPhotoFromVideoObject(video)
                        break
                    } else if type == .photo, let photo = attach.photo {
                        image = getBestQualityPhotoFromObject(photo)
                        break
                    }
                }
            }
        }
        return image
    }
    
    class func getBestQualityPhotoFromObject(_ object: PhotoModel) -> String? {
        return forloopSearchFirstNonnullObjectInStringArray(
            [
                object.photo2560,
                object.photo1280,
                object.photo807,
                object.photo604,
                object.photo130,
                object.photo75
            ]
        )
    }
    
    class func getBestQualityPhotoFromVideoObject(_ object: VideoModel) -> String? {
        return forloopSearchFirstNonnullObjectInStringArray(
            [
                object.firstFrame1280,
                object.firstFrame800,
                object.firstFrame640,
                object.firstFrame320,
                object.firstFrame130,
                object.photo1280,
                object.photo800,
                object.photo640,
                object.photo320,
                object.photo130
            ]
        )
    }
    
    /// Cycle for finding a first nonnull string in Array (FIFO pattern)
    ///
    /// - Parameter array: Array of strings
    /// - Returns: String or nil if nothing founded
    private class func forloopSearchFirstNonnullObjectInStringArray(_ array: [String?]) -> String? {
        for item in array {
            if let i = item {
                return i
            }
        }
        return nil
    }
    
    class func getLinkFromAttachments(_ attachments: [AttachmentModel]?) -> LinkModel? {
        if let attachments = attachments {
            for attach in attachments {
                if let type = attach.type, type == .link, let link = attach.link {
                    return link
                }
            }
        }
        return nil
    }
    
    class func getCurrentPostModelFromPost(_ post: PostModel) -> PostModel {
        if let copyHistory = post.copyHistory {
            if let historyPost = copyHistory.first {
                return getCurrentPostModelFromPost(historyPost)
            }
        }
        return post
    }
    
    class func findUserInArrayById(_ id: Int, users: [ProfileModel]) -> ProfileModel? {
        for user in users {
            if user.id == id {
                return user
            }
        }
        return nil
    }
    
    class func findGroupInArrayById(_ id: Int, groups: [GroupModel]) -> GroupModel? {
        let groupId = id < 0 ? id * -1 : id
        for group in groups {
            if group.id == groupId {
                return group
            }
        }
        return nil
    }
    
    class func filterAttachmentsArrayForAudio(_ array: [AttachmentModel]) -> [AudioModel] {
        var results = [AudioModel]()
        for object in array {
            if object.type == AttachmentType.audio {
                results.append(object.audio!)
            }
        }
        return results
    }
}
