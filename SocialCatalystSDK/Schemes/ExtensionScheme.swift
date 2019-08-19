//
//  ExtensionScheme.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 16/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public protocol ExtensionScheme {
    
    var blockViews: [SCView]? { get set }
    
}

public enum ExtensionViewPosition {
    case bottom
    case top
}
