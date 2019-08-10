//
//  ConfigurationManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 03/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import VK_ios_sdk
import Appodeal
import MagicalRecord
import OneSignal

class ConfigurationManager {
    static let shared = ConfigurationManager()
    
    private init() {}
    
    let colorAppearance: ColorScheme = 
    
    let settings: SettingsScheme =
    
    func isEnabledAdsForPage(_ page: AdsModes) -> Bool {
        if settings.adsModes.contains(page) {
            return true
        }
        return false
    }
    
    static func makeConfiguration(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        MagicalRecord.setupCoreDataStack()
        MagicalRecord.setLoggingLevel(.off)
        VKSdk.initialize(withAppId: ConfigurationManager.shared.settings.appId)
        Appodeal.initialize(withApiKey: ConfigurationManager.shared.settings.appodealKey, types: [.banner, .nativeAd], hasConsent: true)
        
        if ConfigurationManager.shared.settings.availablePushNotifications {
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: ConfigurationManager.shared.settings.oneSignalKey,
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
            
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
            })
        }
        
        UINavigationBar.appearance().barTintColor = ConfigurationManager.shared.colorAppearance.mainColor
        UITabBar.appearance().barTintColor = ConfigurationManager.shared.colorAppearance.tintColor
        UINavigationBar.appearance().tintColor = ConfigurationManager.shared.colorAppearance.tintColor
        UITabBar.appearance().tintColor = ConfigurationManager.shared.colorAppearance.mainColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:ConfigurationManager.shared.colorAppearance.tintColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barStyle = .blackTranslucent
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    @objc private func applicationWillTerminate() {
        MagicalRecord.cleanUp()
    }
}
