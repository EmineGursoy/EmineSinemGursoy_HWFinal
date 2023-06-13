//
//  DetailRouter.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import Foundation

protocol DetailRouterProtocol {
    
}

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
        }
    
}
extension DetailRouter: DetailRouterProtocol {
    
}
