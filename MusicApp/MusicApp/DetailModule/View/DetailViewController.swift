//
//  DetailViewController.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import UIKit
import MusicAPI

protocol DetailViewControllerProtocol: AnyObject {
    func changeLike(_ change: Bool)
    func setSingerNameLabel(_ text: String)
    func setCollectionLabel(_ text: String)
    func playMusic(_ url: String)
    func setSongNameLabel(_ text: String)
    func setSongTypeLabel(_ text: String)
    func setTrackPriceLabel(_ text: String)
    func setCollectionPriceLabel(_ text: String)
    func getSource() -> Music?
    func setImg(url: URL)
}

final class DetailViewController: BaseViewController {
    
    @IBOutlet weak var singerPicImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songTypeLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!
    
    var presenter: DetailPresenterProtocol!
    var source: Music?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        presenter.likeButtonClicked()
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        presenter.playButtonClicked()
    }
    

}
extension DetailViewController: DetailViewControllerProtocol {
    
    func setImg(url: URL) {
        singerPicImageView.sd_setImage(with: url)
    }
    
    func getSource() -> Music? {
        return source
    }
   
    func changeLike(_ change: Bool) {
        
    }
    
    func setSingerNameLabel(_ text: String) {
        self.singerNameLabel.text = text
    }
    
    func setCollectionLabel(_ text: String) {
        self.collectionLabel.text = text
    }
    
    func playMusic(_ url: String) {
        
    }
    
    func setSongNameLabel(_ text: String) {
        self.songNameLabel.text = text
    }
    
    func setSongTypeLabel(_ text: String) {
        self.songTypeLabel.text = text
    }
    
    func setTrackPriceLabel(_ text: String) {
        self.trackPriceLabel.text = text
    }
    
    func setCollectionPriceLabel(_ text: String) {
        self.collectionPriceLabel.text = text
    }
}