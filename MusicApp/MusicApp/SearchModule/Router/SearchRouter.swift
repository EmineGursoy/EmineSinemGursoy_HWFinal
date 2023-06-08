//
//  SearchRouter.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation

class SearchRouter: PresenterToRouterSearchProtocol {
    static func execModule(ref: SearchViewController) {
        let presenter = SearchPresenter()
        
        //View
        ref.searchPresenterObject = presenter
        
        //Presenter
        ref.searchPresenterObject?.searchInteractorObject = SearchInteractor()
        ref.searchPresenterObject?.searchViewObject = ref
        
        //Interactor
        ref.searchPresenterObject?.searchInteractorObject?.searchPresenterObject = presenter
    }
}
