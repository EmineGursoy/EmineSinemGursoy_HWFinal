//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Emine Sinem on 6.06.2023.
//

import UIKit
import MusicAPI

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let service: MusicServiceProtocol = MusicService()
    private var musics: [Music] = []
    
    var searchPresenterObject: ViewToPresenterSearchProtocol?
    var musicList: [Music] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetchMusics()
        searchPresenterObject?.viewPosts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        SearchRouter.execModule(ref: self)
    }
    
    /*
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
        
    } */
    
}

extension SearchViewController: PresenterToViewSearchProtocol {
    func sendDataToView(postList: [Music]) {
        DispatchQueue.main.async {
            self.musicList = postList
            self.collectionView.reloadData()
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        cell.configureCell(model: self.musicList[indexPath.row])
        return cell
    }
    
}

