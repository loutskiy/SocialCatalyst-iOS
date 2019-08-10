//
//  ViewController.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ConfigurationManager.shared.colorAppearance.statusBarStyle
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
            linkUrl = "https://vk.com/wall\(ConfigurationManager.shared.settings.groupId)_\(post.id ?? 0)"
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
}
