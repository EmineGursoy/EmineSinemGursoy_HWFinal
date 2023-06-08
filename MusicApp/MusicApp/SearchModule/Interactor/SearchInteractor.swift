//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI

class SearchInteractor: PresenterToInteractorSearchProtocol {
    var searchPresenterObject: InteractorToPresenterSearchProtocol?
    
    func getAllPosts() {
        MusicService().fetchMusics{ result in
            switch result {
            case .success(let posts):
                self.searchPresenterObject?.sendDataToPresenter(postList: posts)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
