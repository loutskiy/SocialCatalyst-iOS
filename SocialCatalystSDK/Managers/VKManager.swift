//
//  VKManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 04/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import VK_ios_sdk
import ObjectMapper

class VKManager {
    
    static func getWall(offset:Int = 0, success: @escaping(_ posts: ArrayModel<PostModel>) -> Void, fail: @escaping(_ error: Error) -> Void) {
        let request = VKRequest(
            method: "wall.get",
            parameters: [
                VK_API_OWNER_ID: SocialCatalystSDK.shared.getSettings().groupId,
                VK_API_COUNT: 20,
                VK_API_ACCESS_TOKEN: SocialCatalystSDK.shared.getSettings().serverKey,
                VK_API_OFFSET: offset,
                VK_API_EXTENDED: true
            ]
        )
        
        request?.execute(resultBlock: { (response) in
            if let response = response {
                let model = ArrayModel<PostModel>(JSON: response.json as! [String: Any])
                if let model = model {
                    success(model)
                }
            } else {
                
            }
        }, errorBlock: { (error) in
            fail(error!)
        })
    }
    
    static func getGroupInfo(groupId: Int = SocialCatalystSDK.shared.getSettings().groupId, success: @escaping(_ group: VKGroup) -> Void, fail: @escaping(_ error: Error) -> Void) {
        let groupId = groupId < 0 ? groupId * -1 : groupId
        VKApi.groups().getById([VK_API_GROUP_ID: groupId, VK_API_ACCESS_TOKEN: SocialCatalystSDK.shared.getSettings().serverKey, VK_API_FIELDS: "description,photo_100,photo_200"])?.execute(resultBlock: { (response) in
            if let groups = response?.parsedModel as? VKGroups, let group = groups.firstObject() {
                success(group)
            }
        }, errorBlock: { (error) in
            fail(error!)
        })
    }
    
    static func getPostsByIds(_ idsString: String, success: @escaping(_ posts: [PostModel]) -> Void, fail: @escaping(_ error: Error) -> Void) {
        let request = VKRequest(
            method: "wall.getById",
            parameters: [
                "posts": idsString,
                VK_API_ACCESS_TOKEN: SocialCatalystSDK.shared.getSettings().serverKey
            ]
        )
        print(idsString)
        
        request?.execute(resultBlock: { (response) in
            if let response = response {
                let model = Mapper<PostModel>().mapArray(JSONObject: response.json)
                success(model ?? [PostModel]())
            } else {
                
            }
        }, errorBlock: { (error) in
            fail(error!)
        })
    }
    
    static func getCommentsForPost(id: Int, offset: Int = 0, success: @escaping(_ comments: ArrayModel<CommentModel>) -> Void, fail: @escaping(_ error: Error) -> Void) {
        let request = VKRequest(
            method: "wall.getComments",
            parameters: [
                VK_API_ACCESS_TOKEN: SocialCatalystSDK.shared.getSettings().serverKey,
                VK_API_OWNER_ID: SocialCatalystSDK.shared.getSettings().groupId,
                VK_API_POST_ID: id,
                "need_likes": true,
                VK_API_OFFSET: offset,
                VK_API_COUNT: 20,
                VK_API_SORT: "desc",
                "preview_length": 0,
                VK_API_EXTENDED: true
            ]
        )
        request?.execute(resultBlock: { (response) in
            if let response = response {
                let model = ArrayModel<CommentModel>(JSON: response.json as! [String: Any])
                if let model = model {
                    success(model)
                }
            } else {
                
            }
        }, errorBlock: { (error) in
            fail(error!)
        })
    }
    
    static func getUserById(_ id: Int, success: @escaping(_ user: VKUser) -> Void, fail: @escaping(_ error: Error) -> Void) {
        VKApi.users()?.get([
            VK_API_USER_IDS: id,
            VK_API_FIELDS: "photo_100",
            VK_API_ACCESS_TOKEN: SocialCatalystSDK.shared.getSettings().serverKey
            ])?.execute(resultBlock: { (response) in
                if let users = response?.parsedModel as? VKUsersArray {
                    if let user = users.firstObject() {
                        success(user)
                    }
                }
            }, errorBlock: { (error) in
                fail(error!)
            })
    }
}
