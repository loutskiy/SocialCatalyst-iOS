//
//  AboutVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import MessageUI
//import Appodeal

class AboutVC: ViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var developerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeButton.setTitleColor(SocialCatalystSDK.shared.getColorAppearance().buttonColor, for: .normal)
        developerButton.setTitleColor(SocialCatalystSDK.shared.getColorAppearance().buttonColor, for: .normal)

        VKManager.getGroupInfo(success: {
            group  in
            self.titleLabel.text = group.name
            self.descriptionLabel.text = group.description
        }, fail: {
            error in
            self.showAlert(title: "Ошибка", message: error.localizedDescription)
        })
        
        if SocialCatalystSDK.shared.isEnabledAdsForPage(.about) {
//            Appodeal.showAd(.bannerBottom, rootViewController: self)
        }
    }

    @IBAction func writeAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([SocialCatalystSDK.shared.getSettings().supportEmail])
            mail.setSubject(SocialCatalystSDK.shared.getSettings().emailSubject)
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Ошибка", message: "Необходимо настроить почтовую программу")
        }
    }
    
    @IBAction func openLWTS(_ sender: Any) {
        UIApplication.shared.open(URL(string: SocialCatalystSDK.shared.getSettings().siteUrl)!, options: [:], completionHandler: nil)
    }
}

extension AboutVC: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
