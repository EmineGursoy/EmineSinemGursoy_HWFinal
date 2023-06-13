//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI

typealias MusicSourcesResult = Result<[Music], Error>

//MARK: Presenter -> InteractorProtocol
protocol SearchInteractorProtocol: AnyObject {
    var searchText: String { get set }
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
    
    init(service: MusicServiceProtocol = MusicService()) {
        self.service = service
    }
    
    func fetchMusic(text: String) {
        musicService.fetchMusics(searchText: text) { [weak self] result in
            guard let self else { return }
            self.output?.showMusicOutput(result)
        }
    }
}
