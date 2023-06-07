//
//  CollectionView+Extension.swift
//  MusicApp
//
//  Created by Emine Sinem on 6.06.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as?  T else {
            fatalError("Error")
        }
        return cell
    }
}
