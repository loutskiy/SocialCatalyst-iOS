//
//  SettingsScheme.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 06/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public enum PostTypes {
    case readingMode
    case webMode
    case nativeMode
    case customJSRulesMode
    case disable
}

public enum AdsModes {
    case feed
    case favourite
    case post
    case site
    case about
    case comments
}

public enum AdsEngine {
    case appodeal
    case google
    case none
}

public protocol SettingsScheme {
    var appId: String { get set }
    var groupId: Int { get set }
    var serverKey: String { get set }
    var appodealKey: String { get set }
    var availableComments: Bool { get set }
    var availableLikes: Bool { get set }
    var postViewMode: PostTypes { get set }
    var supportEmail: String { get set }
    var siteUrl: String { get set }
    var emailSubject: String { get set }
    var availablePostView: Bool { get set }
    var adsModes: [AdsModes] { get set }
    var adsEngine: AdsEngine { get set }
    var feedTitleName: String { get set }
    var availablePushNotifications: Bool { get set }
    var oneSignalKey: String? { get set }
    var googleAdmobKey: String? { get set }
}
