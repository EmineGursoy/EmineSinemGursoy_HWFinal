//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI
import AVFoundation

typealias MusicSourcesResult = Result<[Music], Error>

//MARK: Presenter -> InteractorProtocol
protocol SearchInteractorProtocol: AnyObject {
    var searchText: String { get set }
    
    func playButtonClicked(music: Music)
    func stopAllMusic()
}

//MARK: InteractorOutput -> Presenter
protocol SearchInteractorOutputProtocol {
    func showMusicOutput(_ result: MusicSourcesResult)
    func showEmptySearchList()
}

fileprivate var musicService: MusicServiceProtocol = MusicService()

final class SearchInteractor: SearchInteractorProtocol {
    private let service: MusicServiceProtocol
    
    var output: SearchInteractorOutputProtocol?
    var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                output?.showEmptySearchList()
            } else {
                fetchMusic(text: searchText)
            }
        }
    }
    
    var player: AVPlayer?
    var playedMusic: Music?
    
    init(service: MusicServiceProtocol = MusicService()) {
        self.service = service
    }
    
    func fetchMusic(text: String) {
        musicService.fetchMusics(searchText: text) { [weak self] result in
            guard let self else { return }
            self.output?.showMusicOutput(result)
        }
    }
    
    func playButtonClicked(music: Music) {
        if playedMusic?.trackID == music.trackID {
            player?.pause()
            player = nil
            playedMusic = nil
        } else {
            let urlString = music.previewURL ?? ""
            
            guard let url = URL(string: urlString) else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVPlayer(url: url as URL)
                player?.volume = 5.0
                guard let player = player else { return }
                player.play()
                playedMusic = music

            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func stopAllMusic() {
        player?.pause()
        player = nil
        playedMusic = nil
    }
}
