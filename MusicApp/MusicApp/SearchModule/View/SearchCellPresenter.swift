//
//  SearchCellPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 11.06.2023.
//

import UIKit
import MusicAPI

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
    func playButtonClicked()
}

protocol SearchCellPresenterInputProtocol: AnyObject {
    func playButtonClicked(music: Music, from cellPresenter: SearchCellPresenter)
}

final class SearchCellPresenter {
    
    weak var view: SearchCellProtocol?
    weak var input: SearchCellPresenterInputProtocol?
    private let music: Music
    
    init(
        view: SearchCellProtocol?,
        input: SearchCellPresenterInputProtocol?,
        music: Music
    ){
        self.view = view
        self.input = input
        self.music = music
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
   
    func playButtonClicked() {
        input?.playButtonClicked(music: music, from: self)
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
    
    func updatePlayButton(isPlaying: Bool) {
        view?.updatePlayButton(isPlaying: isPlaying)
    }
}
