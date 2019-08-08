//
//  ColorScheme.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 03/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol ColorScheme {
    var mainColor: UIColor { get set }
    var tintColor: UIColor { get set }
    var buttonColor: UIColor { get set }
    var statusBarStyle: UIStatusBarStyle { get set }
}
