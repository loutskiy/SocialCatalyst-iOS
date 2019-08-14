//
//  NotificationName+extensions.swift
//  VMusic
//
//  Created by Mikhail Lutskiy on 23.08.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let nextTrack = Notification.Name("playNextSong")
    static let previousTrack = Notification.Name("playPreviousSong")
    static let playTrackAtIndex = Notification.Name("playTrackAtIndex")
    static let reloadData = Notification.Name("reloadData")
}
