//
//  SearchRouter.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI
import UIKit

protocol SearchRouterProtocol {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(source: Music?)
}

final class SearchRouter {
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let source):
            
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
