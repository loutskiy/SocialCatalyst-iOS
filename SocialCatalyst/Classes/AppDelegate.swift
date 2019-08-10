//
//  AppDelegate.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 02/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ConfigurationManager.makeConfiguration(launchOptions: launchOptions)
        return true
    }

}

