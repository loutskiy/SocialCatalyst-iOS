//
//  CoreDataManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import MagicalRecord

class CoreDataManager: NSObject {
    
    class func addToFavourite(postId: Int) {
        if let record = CDFavourite.mr_findFirst(byAttribute: "postId", withValue: Int64(postId)){
            record.mr_deleteEntity()
        } else {
            let record = CDFavourite.mr_createEntity()
            record?.postId = Int64(postId)
        }
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: { (_, _) -> Void in
        })
    }
    
    class func haveInFavourite(postId: Int) -> Bool {
        if CDFavourite.mr_findFirst(byAttribute: "postId", withValue: Int64(postId)) != nil {
            return true
        } else {
            return false
        }
    }
    
    class func getAllFromFavourites() -> String {
        if let favourites = CDFavourite.mr_findAll() as? [CDFavourite] {
            var str = ""
            for favourite in favourites {
                str = str + "\(SocialCatalystSDK.shared.getSettings().groupId)_\(favourite.postId),"
            }
            return str
        }
        return ""
    }

}
