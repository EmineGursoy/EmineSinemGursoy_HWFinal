//
//  UICollectionViewCell+Extension.swift
//  MusicApp
//
//  Created by Emine Sinem on 6.06.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
