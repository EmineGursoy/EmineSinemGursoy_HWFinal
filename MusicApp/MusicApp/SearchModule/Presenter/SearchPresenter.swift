//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI

class SearchPresenter: ViewToPresenterSearchProtocol {
    var searchInteractorObject: PresenterToInteractorSearchProtocol?
    var searchViewObject: PresenterToViewSearchProtocol?
    
    func viewPosts() {
        searchInteractorObject?.getAllPosts()
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    func sendDataToPresenter(postList: [Music]) {
        searchViewObject?.sendDataToView(postList: postList)
    }
}
