//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import Foundation
import UIKit
import AVFoundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func playButtonClicked()
    func likeButtonClicked()
}

final class DetailPresenter {
    
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    
    init(
        view: DetailViewControllerProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
    
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        guard let music = view.getSource() else { return } 
       
        guard let urlString = music.artworkUrl100 else { return }
        if let url = URL(string: urlString) {
            view?.setImg(url: url)
        }
        
        view.setSingerNameLabel(music.artistName ?? "")
        view.setSongNameLabel(music.trackName ?? "")
        view.setCollectionLabel(music.collectionName ?? "")
        view.setSongTypeLabel(music.primaryGenreName ?? "")
        
        guard let trackPrice = music.trackPrice else { return }
        guard let collectionPrice = music.collectionPrice else { return }
        view.setTrackPriceLabel("Track Price: $ \(trackPrice)")
        view.setCollectionPriceLabel("Collection Price: $ \(collectionPrice)")
    }
    
    func playButtonClicked() {
        guard let music = view.getSource() else { return }
        let urlString = music.previewURL ?? ""
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
    
    func likeButtonClicked() {
        
    }
}
