//
//  CommandCenter.swift
//  VMusic
//
//  Created by Mikhail Lutskiy on 23.08.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import MediaPlayer

class CommandCenter: NSObject {
    
    static let defaultCenter = CommandCenter()
    
    fileprivate let player = AudioPlayer.defaultPlayer
    
    override init() {
        super.init()
        setCommandCenter()
        setAudioSeccion()
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
    //AVAudioSessionCategoryOptions
    func getUserCategoryOption() -> AVAudioSessionCategoryOptions {
        let isSetToSpeaker = UserDefaults.standard.value(forKey: "mixAudioWithOthers") as? Bool ?? true
        return isSetToSpeaker ? .defaultToSpeaker : .mixWithOthers
    }
    
    func setAudioSeccion() { //TODO: Change to .defaultToSpeaker to show music controls on Locked Screen or .mixWithOthers not to show
        do { try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: getUserCategoryOption())
            do { try AVAudioSession.sharedInstance().setActive(true) }
            catch let error as NSError { print(error.localizedDescription) }
        }
        catch let error as NSError { print(error.localizedDescription) }
    }
    
    //MARK: - Remote Command Center
    fileprivate func setCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.pauseCommand.addTarget(self, action: #selector(CommandCenter.remoteCommandPause))
        commandCenter.playCommand.addTarget(self, action: #selector(CommandCenter.remoteCommandPlay))
        commandCenter.previousTrackCommand.addTarget(self, action: #selector(CommandCenter.remoteCommandPrevious))
        commandCenter.nextTrackCommand.addTarget(self, action: #selector(CommandCenter.remoteCommandNext))
    }
    
    @objc fileprivate func remoteCommandPause() {
        player.pause()
    }
    
    @objc fileprivate func remoteCommandPlay() {
        player.play()
    }
    
    @objc fileprivate func remoteCommandNext() {
        player.next()
    }
    
    @objc fileprivate func remoteCommandPrevious() {
        player.previous()
    }
    
    //MARK: - Public Methods
    
    func setNowPlayingInfo(artworkImage: UIImage) {
        DispatchQueue.main.sync {
            
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyPlaybackDuration: player.currentAudio.duration,
            MPMediaItemPropertyTitle: player.currentAudio.title,
            MPMediaItemPropertyArtist: player.currentAudio.artist,
            MPMediaItemPropertyArtwork: MPMediaItemArtwork(image: artworkImage),
            MPNowPlayingInfoPropertyPlaybackRate: 1.0]
        }
    }
}
