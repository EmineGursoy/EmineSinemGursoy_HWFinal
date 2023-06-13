//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import Foundation

protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol {
    func fetchMusicDetailOutput(result: MusicSourcesResult)
    
}

final class DetailInteractor {
    var output: SearchInteractorOutputProtocol?
}
