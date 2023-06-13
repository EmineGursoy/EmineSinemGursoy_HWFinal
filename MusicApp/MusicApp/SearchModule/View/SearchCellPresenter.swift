//
//  SearchCellPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 11.06.2023.
//

import UIKit
import MusicAPI
import AVFoundation

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
    func playButtonClicked()
}

final class SearchCellPresenter {
    
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    weak var view: SearchCellProtocol?
    private let music: Music
    
    init(
        view: SearchCellProtocol?,
        music: Music
    ){
        self.view = view
        self.music = music
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
   
    func playButtonClicked() {
     
        guard let urlString = music.previewURL else { return }
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
    
   
    func load() {
        guard let urlString = music.artworkUrl100 else { return }
        if let url = URL(string: urlString) {
            view?.setImg(url: url)
        }
        view?.setSongName(music.trackName ?? "")
        view?.setSingerName(music.artistName ?? "")
        view?.setCollectionName(music.collectionName ?? "")
    }
    
}
