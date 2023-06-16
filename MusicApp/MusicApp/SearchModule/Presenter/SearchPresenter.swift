//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func musics(_ index: Int) -> Music?
    func didSelectRowAt(index: Int)
    func textDidChange(searchText: String)
    func searchBarCancelButtonClicked()
    func playButtonClicked(music: Music)
}

final class SearchPresenter {
    
    private var musics: [Music] = []
    private var musicList: [Music] = []
    
    unowned var view: SearchViewControllerProtocol
    let interactor: SearchInteractorProtocol!
    let router: SearchRouterProtocol!
    
    init(
        view: SearchViewControllerProtocol,
        interactor: SearchInteractorProtocol,
        router: SearchRouterProtocol)
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func searchBarCancelButtonClicked() {
        view.setSearchBar()
        view.reloadData()
        interactor.searchText = ""
    }
    
    func textDidChange(searchText: String) {
        interactor.searchText = searchText
    }
    
    func viewDidLoad() {
        view.setUpCollectionView()
        view.setTitle("iTunes Search")
        interactor.searchText = ""
    }
    
    func numberOfItems() -> Int {
        musics.count
    }
    
    func musics(_ index: Int) -> Music? {
        return musics[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        let source = musics[index]
        
        interactor.stopAllMusic()
        router.navigate(.detail(source: source))
    }
    
    func playButtonClicked(music: Music) {
        interactor.playButtonClicked(music: music)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func showEmptySearchList() {
        view.showEmptyResultList()
    }
    
    func showMusicOutput(_ result: MusicSourcesResult) {
        switch result {
        case .success(let response):
            self.musics = response
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
    }
}
