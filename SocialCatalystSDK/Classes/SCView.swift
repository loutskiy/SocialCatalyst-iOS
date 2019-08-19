//
//  SCView.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 16/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public class SCView: UIView {
    
    private var position: ExtensionViewPosition!
    
    private var availableForPages: [InventarVC]!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, position: ExtensionViewPosition, availableForPages: [InventarVC]) {
        super.init(frame: frame)
        self.position = position
        self.availableForPages = availableForPages
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getViewPosition() -> ExtensionViewPosition {
        return position
    }
    
    func getAvailableForPages() -> [InventarVC] {
        return availableForPages
    }
}
