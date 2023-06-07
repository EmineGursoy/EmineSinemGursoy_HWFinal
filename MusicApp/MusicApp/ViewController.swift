//
//  ViewController.swift
//  MusicApp
//
//  Created by Emine Sinem on 6.06.2023.
//

import UIKit
import MusicAPI

class ViewController: UIViewController {
    
    let service: MusicServiceProtocol = MusicService()
    private var musics: [Music] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMusics()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func fetchMusics() {
        service.fetchMusics { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let musics):
                print(musics)
                self.musics = musics
            case .failure(let error):
                print(error)
            }
        
        }
        
    }


}

