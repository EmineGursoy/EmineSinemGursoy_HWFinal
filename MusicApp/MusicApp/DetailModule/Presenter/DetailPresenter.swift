//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import Foundation
import UIKit
import MusicAPI

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func playButtonClicked()
    func stopMusic()
    func likeButtonClicked()
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol!
    let interactor: DetailInteractorProtocol
    let router: DetailRouterProtocol!
    
    init(
        view: DetailViewControllerProtocol,
        interactor: DetailInteractorProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }    
}

extension DetailPresenter: DetailPresenterProtocol, DetailInteractorOutputProtocol {
    func updateLikeButton(isLiked: Bool) {
        view.changeLike(isLiked)
    }
    
    func updatePlayButton(isPlaying: Bool) {
        view.changePlay(isPlaying)
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func showMusicDetail(_ music: Music, isLiked: Bool) {
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
        
        view.changeLike(isLiked)
    }
    
    func playButtonClicked() {
        interactor.playButtonClicked()
    }
    
    func likeButtonClicked() {
        interactor.likeButtonClicked()
    }
    
    func stopMusic() {
        interactor.stopMusic()
    }
}
