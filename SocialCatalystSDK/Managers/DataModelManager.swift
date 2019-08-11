//
//  DataModelManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class DataModelManager {
    
    class func getPhotoFromAttachments(_ attachments: [AttachmentModel]?) -> String? {
        var image: String?
        if let attachments = attachments {
            for attach in attachments {
                if let type = attach.type {
                    if type == .link, let link = attach.link, image == nil || image == "", let photo = link.photo {
                        image = getBestQualityPhotoFromObject(photo)
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
        if let photo2560 = object.photo2560 {
            return photo2560
        } else if let photo1280 = object.photo1280 {
            return photo1280
        } else if let photo807 = object.photo807 {
            return photo807
        } else if let photo604 = object.photo604 {
            return photo604
        } else if let photo130 = object.photo130 {
            return photo130
        } else if let photo75 = object.photo75 {
            return photo75
        } else {
            return nil
        }
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
}
