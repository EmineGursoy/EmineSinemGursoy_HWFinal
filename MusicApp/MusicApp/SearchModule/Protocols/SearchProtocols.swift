//
//  SearchProtocols.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import Foundation
import MusicAPI

protocol ViewToPresenterSearchProtocol {
    var searchInteractorObject: PresenterToInteractorSearchProtocol? { get set }
    var searchViewObject: PresenterToViewSearchProtocol? {get set}
    func viewPosts()
}

protocol PresenterToInteractorSearchProtocol {
    var searchPresenterObject: InteractorToPresenterSearchProtocol? {get set}
    func getAllPosts()
}

protocol InteractorToPresenterSearchProtocol {
    func sendDataToPresenter(postList: [Music])
}

protocol PresenterToViewSearchProtocol {
    func sendDataToView(postList: [Music])
}

protocol PresenterToRouterSearchProtocol {
    static func execModule(ref: SearchViewController)
}
