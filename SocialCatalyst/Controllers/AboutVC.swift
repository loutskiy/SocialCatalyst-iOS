//
//  AboutVC.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import MessageUI
import Appodeal

class AboutVC: ViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var developerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeButton.setTitleColor(ConfigurationManager.shared.colorAppearance.buttonColor, for: .normal)
        developerButton.setTitleColor(ConfigurationManager.shared.colorAppearance.buttonColor, for: .normal)

        VKManager.getGroupInfo(success: {
            group  in
            self.titleLabel.text = group.name
            self.descriptionLabel.text = group.description
        }, fail: {
            error in
            self.showAlert(title: "Ошибка", message: error.localizedDescription)
        })
        
        if ConfigurationManager.shared.isEnabledAdsForPage(.about) {
            Appodeal.showAd(.bannerBottom, rootViewController: self)
        }
    }

    @IBAction func writeAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([ConfigurationManager.shared.configApiVK.supportEmail])
            mail.setSubject(ConfigurationManager.shared.configApiVK.emailSubject)
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Ошибка", message: "Необходимо настроить почтовую программу")
        }
    }
    
    @IBAction func openLWTS(_ sender: Any) {
        UIApplication.shared.open(URL(string: ConfigurationManager.shared.configApiVK.siteUrl)!, options: [:], completionHandler: nil)
    }
}

extension AboutVC: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
