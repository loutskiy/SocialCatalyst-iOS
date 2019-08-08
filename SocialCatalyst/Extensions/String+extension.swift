//
//  String+extension.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 04/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

extension String {
    func removingUrls() -> String {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return self
        }
        return detector.stringByReplacingMatches(in: self,
                                                 options: [],
                                                 range: NSRange(location: 0, length: self.utf16.count),
                                                 withTemplate: "")
    }
}
