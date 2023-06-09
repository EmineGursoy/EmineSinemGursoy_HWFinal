//
//  SearchCell.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import UIKit
import SDWebImage
import MusicAPI
import AVFoundation

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var singerPicImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Configures song cell
    func configureCell(model: Music) {
        singerNameLabel.text = model.artistName
        songNameLabel.text = model.trackName
        collectionLabel.text = model.collectionName
        prepareImage(with: model.artworkUrl100)
    }
    
    private func prepareImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        if let url = URL(string: urlString) {
            singerPicImageView.sd_setImage(with: url)
        }
    }
    
    func playSound() {
        let urlString = "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/b3/5f/8b/b35f8bfc-7450-6c6a-a01d-c0ad1dbce2e8/mzaf_13236724710233336637.plus.aac.p.m4a"
        guard let url = URL(string: urlString) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVPlayer(url: url as URL)
            player?.volume = 5.0
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func playButtonClicked(_ sender: Any) {
        isPlaying = !isPlaying
        let image = isPlaying ? "play.circle" : "stop.circle"
        playButton.setImage(UIImage(named: image), for: .normal)
        
        playSound()
    }
}
