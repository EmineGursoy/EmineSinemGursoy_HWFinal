//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Emine Sinem on 6.06.2023.
//

import UIKit
import MusicAPI

protocol SearchViewControllerProtocol: AnyObject {
    func setUpCollectionView()
    func reloadData()
    func showError(_ message: String)
    func setTitle(_ title: String)
    func setSearchBar()
    func showEmptyResultList()
}

final class SearchViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptySearchLabel: UILabel!
    
    let service: MusicServiceProtocol = MusicService()
    
    var musicList: [Music] = []
    
    var filteredMusicList = [Music]()
    var isFiltering: Bool = false
    
    var selectedMusic: Music?
    
    var presenter: SearchPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        
        if let music = presenter.musics(indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, music: music)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.textDidChange(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonClicked()
    }
     
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func setSearchBar() {
        searchBar.text = ""
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if self.presenter.numberOfItems() > 0 {
                self.collectionView.isHidden = false
                self.emptySearchLabel.isHidden = true
                self.collectionView.reloadData()
            } else {
                self.collectionView.isHidden = true
                self.emptySearchLabel.isHidden = false
            }
        }
    }
    
    func showError(_ message: String) {
        makeAlert("Error", message)
    }
    
    func showEmptyResultList() {
        collectionView.isHidden = true
        emptySearchLabel.isHidden = false
    }
}

