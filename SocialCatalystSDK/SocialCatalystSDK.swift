//
//  SocialCatalystSDK.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 03/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import VK_ios_sdk
import Appodeal
import MagicalRecord
//import OneSignal

public class SocialCatalystSDK: NSObject, UIApplicationDelegate {
    static let shared = SocialCatalystSDK()
    
    private override init() {}
    
    private var colorAppearance: ColorScheme!
    
    private var settings: SettingsScheme!
    
    func isEnabledAdsForPage(_ page: AdsModes) -> Bool {
        if settings.adsModes.contains(page) {
            return true
        }
        return false
    }
    
    /// Function for initialize SocialCatalystSDK. Place this to your AppDelegate
    ///
    /// - Parameters:
    ///   - launchOptions: LaunchOptions from AppDelegate
    ///   - colorScheme: Your color scheme
    ///   - settingsScheme: Your settings scheme
    ///   - configuredWith: uiwindow object for display ui of SDK
    public class func setSocialCatalystConfiguration(launchOptions: [UIApplication.LaunchOptionsKey: Any]?, colorScheme: ColorScheme, settingsScheme: SettingsScheme, configuredWith: @escaping(_ window: UIWindow) -> Void) {
        SocialCatalystSDK.shared.colorAppearance = colorScheme
        SocialCatalystSDK.shared.settings = settingsScheme
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [getBundle()])
        MagicalRecord.setShouldAutoCreateManagedObjectModel(false)
        NSManagedObjectModel.mr_setDefaultManagedObjectModel(managedObjectModel)
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "Model.sqlite")
//        
        MagicalRecord.setLoggingLevel(.off)
        VKSdk.initialize(withAppId: SocialCatalystSDK.shared.getSettings().appId)
//
        Appodeal.setLogLevel(.verbose)
        Appodeal.initialize(withApiKey: SocialCatalystSDK.shared.getSettings().appodealKey, types: [.banner, .nativeAd])
        
        if SocialCatalystSDK.shared.getSettings().availablePushNotifications {
//            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
//            
//            OneSignal.initWithLaunchOptions(launchOptions,
//                                            appId: SocialCatalystSDK.shared.getSettings().oneSignalKey,
//                                            handleNotificationAction: nil,
//                                            settings: onesignalInitSettings)
//            
//            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
//            
//            OneSignal.promptForPushNotifications(userResponse: { accepted in
//                print("User accepted notifications: \(accepted)")
//            })
        }
        
        UINavigationBar.appearance().barTintColor = SocialCatalystSDK.shared.colorAppearance.mainColor
        UITabBar.appearance().barTintColor = SocialCatalystSDK.shared.colorAppearance.tintColor
        UINavigationBar.appearance().tintColor = SocialCatalystSDK.shared.colorAppearance.tintColor
        UITabBar.appearance().tintColor = SocialCatalystSDK.shared.colorAppearance.mainColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:SocialCatalystSDK.shared.colorAppearance.tintColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barStyle = .blackTranslucent
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: getBundle())
        let vc = storyboard.instantiateInitialViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        configuredWith(window)
    }
    
    static func getBundle() -> Bundle {
        if let resourceBundle = Bundle(identifier: "ru.lwts.SocialCatalystSDK") {
            return resourceBundle
        } else {
            let frameworkBundle = Bundle(for: SocialCatalystSDK.self)
            let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("SocialCatalyst.bundle")
            let resourceBundle = Bundle(url: bundleURL!)!
            return resourceBundle
        }
    }
    
    @objc private func applicationWillTerminate() {
        MagicalRecord.cleanUp()
    }
    
    func getColorAppearance() -> ColorScheme {
        return self.colorAppearance
    }
    
    func getSettings() -> SettingsScheme {
        return self.settings
    }
}
