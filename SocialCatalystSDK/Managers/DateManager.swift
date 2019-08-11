//
//  DateManager.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 04/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class DateManager {
    
    static func convertDate(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let format = DateFormatter()
        format.dateFormat = "dd MMMM YYYY, HH:mm"
        return format.string(from: date)
    }
    
}
