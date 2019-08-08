//
//  ConfigurationManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 03/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class ConfigurationManager {
    static let shared = ConfigurationManager()
    
    private init() {}
    
    let colorAppearance: ColorScheme = 
    
    let configApiVK: ApiVKScheme =
    
    func isEnabledAdsForPage(_ page: AdsModes) -> Bool {
        if configApiVK.adsModes.contains(page) {
            return true
        }
        return false
    }
}
