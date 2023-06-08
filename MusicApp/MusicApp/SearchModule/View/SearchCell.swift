//
//  SearchCell.swift
//  MusicApp
//
//  Created by Emine Sinem on 7.06.2023.
//

import UIKit
import SDWebImage
import MusicAPI

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var singerPicImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Configures song cell
    func configureCell(model: Music) {
        singerNameLabel.text = model.artistName
        songNameLabel.text = model.trackName
        collectionLabel.text = model.collectionName
        prepareImage(with: model.artworkUrl100)
    }
    
    private func prepareImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        if let url = URL(string: urlString) {
            singerPicImageView.sd_setImage(with: url)
        }
    }
  
}
