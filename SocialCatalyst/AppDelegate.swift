//
//  AppDelegate.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 02/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SocialCatalystSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SocialCatalystSDK.setSocialCatalystConfiguration(
            launchOptions: launchOptions,
            colorScheme: DiggerColorScheme(),
            settingsScheme: DiggerApiVKScheme(),
            configuredWith: { window in
                self.window = window
            }
        )

        return true
    }
}

