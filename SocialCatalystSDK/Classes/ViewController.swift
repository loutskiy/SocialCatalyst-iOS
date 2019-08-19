//
//  ViewController.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import VK_ios_sdk

class ViewController: UIViewController {
    
    let scopes = [VK_PER_PHOTOS, VK_PER_AUDIO, VK_PER_VIDEO, VK_PER_PAGES, VK_PER_WALL, VK_PER_OFFLINE, VK_PER_DOCS, VK_PER_GROUPS, VK_PER_NOTIFICATIONS]

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SocialCatalystSDK.shared.getColorAppearance().statusBarStyle
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = [UIAlertAction(title: "ОК", style: .cancel, handler: nil)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showShare(for post: PostModel, sourceView: UIView) {
        let currentPost = DataModelManager.getCurrentPostModelFromPost(post)
        var linkUrl = ""
        if let link = DataModelManager.getLinkFromAttachments(currentPost.attachments) {
            linkUrl = link.url
        } else {
            linkUrl = "https://vk.com/wall\(SocialCatalystSDK.shared.getSettings().groupId)_\(post.id ?? 0)"
        }
        let vc = UIActivityViewController(activityItems: [URL(string: linkUrl)!, currentPost.text ?? ""], applicationActivities: [])
        present(vc, animated: true)
        if let popOver = vc.popoverPresentationController {
            popOver.sourceView = sourceView
        }
    }
    
    func openComments(for post: PostModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
        vc.post = post
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkVKSession() {
        VKSdk.wakeUpSession(scopes) { (state, error) in
            if state == .authorized {
                
            }
        }
    }
}
