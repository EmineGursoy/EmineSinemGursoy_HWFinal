//
//  DetailRouter.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import Foundation
import MusicAPI

protocol DetailRouterProtocol {
    
}

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule(music: Music) -> DetailViewController {
        let view = DetailViewController()
        let router = DetailRouter()
        let interactor = DetailInteractor(source: music)
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        
        interactor.output = presenter
        view.presenter = presenter
        router.viewController = view
        return view
        }
    
}
extension DetailRouter: DetailRouterProtocol {
    
}
