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
    
    var playedMusicCellPresenter: SearchCellPresenter?
    
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
            cell.cellPresenter = SearchCellPresenter(view: cell, input: self, music: music)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updatePlayButtons(cellPresenter: playedMusicCellPresenter)
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

extension SearchViewController: SearchCellPresenterInputProtocol {
    func playButtonClicked(music: Music, from cellPresenter: SearchCellPresenter) {
        presenter.playButtonClicked(music: music)
        
        updatePlayButtons(cellPresenter: cellPresenter)
    }
    
    func updatePlayButtons(cellPresenter: SearchCellPresenter?) {
        if playedMusicCellPresenter === cellPresenter { // If cellPresenter is the same as the previous played cell presenter, update the play button as not playing
            cellPresenter?.updatePlayButton(isPlaying: false)
            playedMusicCellPresenter = nil
        } else { // else update the previous cell presenter button as not playing, and the current playing cell presenter to is playing
            playedMusicCellPresenter?.updatePlayButton(isPlaying: false)
            playedMusicCellPresenter = cellPresenter
            cellPresenter?.updatePlayButton(isPlaying: true)
        }

    }
}

extension SearchViewController {
    func setAccessibilityIdentifiers() {
        collectionView.accessibilityIdentifier = "collectionView"
    }
}
