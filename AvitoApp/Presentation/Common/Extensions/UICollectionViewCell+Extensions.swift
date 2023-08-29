//
//  UICollectionViewCell+Extensions.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell: Reusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
