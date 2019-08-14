//
//  MusicPlayerVC.swift
//  VMusic
//
//  Created by Mikhail Lutskiy on 23.08.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import LNPopupController
import SDWebImage
import MediaPlayer

class MusicPlayerVC: UIViewController {
    
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var valumeSlider: UISlider!
    @IBOutlet weak var fullPlayerPlayPauseButton: UIButton!
    @IBOutlet weak var currenTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var viewForVolume: UIView!
    
    let accessibilityDateComponentsFormatter = DateComponentsFormatter()
    
    var pauseButton : UIBarButtonItem!
    var playButton : UIBarButtonItem!
    var nextButton : UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        pauseButton = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: self, action: #selector(pauseSong))
        pauseButton.accessibilityLabel = NSLocalizedString("Pause", comment: "")
        playButton = UIBarButtonItem(image: UIImage(named: "play"), style: .plain, target: self, action: #selector(playSong))

        nextButton = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: self, action: #selector(nextSong))
        nextButton.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        
        if UserDefaults.standard.object(forKey: __kMAIN__PopupSettingsBarStyle) as? LNPopupBarStyle == LNPopupBarStyle.compact || ProcessInfo.processInfo.operatingSystemVersion.majorVersion < 10 {
            popupItem.leftBarButtonItems = [ pauseButton ]
            popupItem.rightBarButtonItems = [ nextButton ]
        }
        else {
            popupItem.rightBarButtonItems = [ pauseButton, nextButton ]
        }
        
        accessibilityDateComponentsFormatter.unitsStyle = .spellOut
    }
    
    var songTitle: String = "" {
        didSet {
            if isViewLoaded {
                songNameLabel.text = songTitle
            }
            
            popupItem.title = songTitle
        }
    }
    var albumTitle: String = "" {
        didSet {
            if isViewLoaded {
                albumNameLabel.text = albumTitle
            }
            if ProcessInfo.processInfo.operatingSystemVersion.majorVersion <= 9 {
                popupItem.subtitle = albumTitle
            }
            
            popupItem.subtitle = albumTitle
        }
    }
    var albumArt: UIImage = UIImage() {
        didSet {
            if isViewLoaded {
                albumArtImageView.image = albumArt
            }
            popupItem.image = albumArt
            popupItem.accessibilityImageLabel = NSLocalizedString("Album Art", comment: "")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        AudioPlayer.defaultPlayer.delegate = self
        
        songNameLabel.text = songTitle
        albumNameLabel.text = albumTitle
        albumArtImageView.image = albumArt
        
        changeButtonStyle(button: shuffleButton, state: AudioPlayer.defaultPlayer.isShuffleEnabled)
        changeButtonStyle(button: repeatButton, state: AudioPlayer.defaultPlayer.isRepeatEnabled)
        
//        let volume = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
//        viewForVolume.addSubview(volume)
    }

    func updatePlayButton() {
        if fullPlayerPlayPauseButton.imageView?.image == #imageLiteral(resourceName: "nowPlaying_play") {
            fullPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "nowPlaying_pause"), for: UIControlState())
            playSong()
        } else {
            fullPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "nowPlaying_play"), for: UIControlState())
            pauseSong()
        }
    }
    
    func setPlayButtonIconToPause() {
        fullPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "nowPlaying_pause"), for: UIControlState())
    }
    
    func setPlayButtonIconToPlay() {
        fullPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "nowPlaying_play"), for: UIControlState())
    }
    
    //Play pause songs
    @objc func pauseSong() {
        AudioPlayer.defaultPlayer.pause()
        setPlayButtonIconToPlay()
        popupItem.rightBarButtonItems = [ playButton, nextButton ]
        
//        guard let cell = tableView.cellForRow(at: IndexPath(row: currentIndexPathRow, section: 0)) as? TrackTableViewCell else { return }
//        cell.musicPlayIdicatorView.state = .estMusicIndicatorViewStatePaused
    }
    
    @objc func playSong() {
        AudioPlayer.defaultPlayer.play()
        setPlayButtonIconToPause()
        popupItem.rightBarButtonItems = [ pauseButton, nextButton ]
//        guard let cell = tableView.cellForRow(at: IndexPath(row: currentIndexPathRow, section: 0)) as? TrackTableViewCell else { return }
//        cell.musicPlayIdicatorView.state = .estMusicIndicatorViewStatePlaying
    }
    
    @objc func nextSong() {
        AudioPlayer.defaultPlayer.next()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        AudioPlayer.defaultPlayer.previous()
    }
    
    @IBAction func playAndPauseAction(_ sender: Any) {
        updatePlayButton()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        AudioPlayer.defaultPlayer.next()
    }
    
    @IBAction func volumeAction(_ sender: Any) {
    }
    
    func updateCurrentSong (_ song: VMSongModel) {
        self.albumArt = #imageLiteral(resourceName: "AlbumPlaceholder")
        self.songTitle = song.title
        self.albumTitle = song.artist
        self.popupItem.progress = 0
        self.audioDidChangeTime(0)
        let sourceURL = URL(string: song.url)
        DispatchQueue.global(qos: .background).async {
            AudioPlayer.defaultPlayer.playAudio(fromURL: sourceURL)
        }
        VMusic.shared.getTrackArtwork(artist:song.artist, track: song.title, success: {
            path in
            print("path")
            print(path)
            SDWebImageDownloader.shared().downloadImage(with: URL(string: path), options: [], progress: nil, completed: { (image, data, error, _) in
                self.albumArt = image ?? #imageLiteral(resourceName: "AlbumPlaceholder")
            })
        })
        
    }
    
    @IBAction func makeShuffleAction(_ sender: Any) {
        AudioPlayer.defaultPlayer.isShuffleEnabled = !AudioPlayer.defaultPlayer.isShuffleEnabled
        AudioPlayer.defaultPlayer.shuffle()
        changeButtonStyle(button: shuffleButton, state: AudioPlayer.defaultPlayer.isShuffleEnabled)
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        AudioPlayer.defaultPlayer.isRepeatEnabled = !AudioPlayer.defaultPlayer.isRepeatEnabled
        changeButtonStyle(button: repeatButton, state: AudioPlayer.defaultPlayer.isRepeatEnabled)
    }
    
    func changeButtonStyle ( button: UIButton, state: Bool) {
        if state {
            button.backgroundColor = .VMusicBlue
            button.tintColor = .white
            button.layer.cornerRadius = 5
        } else {
            button.backgroundColor = .clear
            button.tintColor = .VMusicBlue
            button.layer.cornerRadius = 0
        }
    }
}

extension MusicPlayerVC: AudioPlayerDelegate {
    func audioDidChangeTime(_ time: Int64) {
        print(time)
        let progressValue = Float(time) / Float(AudioPlayer.defaultPlayer.currentAudio.duration)
        popupItem.progress = progressValue
        progressView.progress = progressValue
        
        currenTimeLabel.text = Int(time).toAudioString
        durationLabel.text = "-\((Int(AudioPlayer.defaultPlayer.currentAudio.duration) - Int(time)).toAudioString)"
    }
    
    func playerWillPlayNextAudio(_ song: VMSongModel) {
        updateCurrentSong(song)
    }
    
    func playerWillPlayPreviousAudio(_ song: VMSongModel) {
        updateCurrentSong(song)
    }
    
    func receivedArtworkImage(_ image: UIImage) {
        
    }
    
    
}
