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

protocol SearchCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSingerName(_ text: String)
    func setSongName(_ text: String)
    func setCollectionName(_ text: String)
    func setImg(url: URL)
    func playButtonClicked(url: URL)
    func getSource() -> Music?
}

final class SearchCell: UICollectionViewCell {

    @IBOutlet weak var singerPicImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
  
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
     }

    var player: AVPlayer?
    var isPlaying: Bool = false

    var source: Music?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        cellPresenter.playButtonClicked()
    }
}

extension SearchCell: SearchCellProtocol {
    
    func getSource() -> Music? {
        return source
    }
    
    func playButtonClicked(url: URL) {
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
    
    func setImg(url: URL) {
        singerPicImageView.sd_setImage(with: url)
    }
    
    func setSingerName(_ text: String) {
        singerNameLabel.text = text
    }
    
    func setSongName(_ text: String) {
        songNameLabel.text = text
    }
    
    func setCollectionName(_ text: String) {
        collectionLabel.text = text
    }
    
    
    func setImage(_ image: UIImage) {
       /* DispatchQueue.main.async {
            self.singerPicImageView.image = image
        } */
    }
    
}
