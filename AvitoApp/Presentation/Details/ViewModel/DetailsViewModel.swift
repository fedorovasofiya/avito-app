//
//  DetailsViewModel.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 31.08.2023.
//

import Foundation
import UIKit

protocol DetailsViewModel {
    var dataLoaded: ((AdItem) -> Void)? { get set }
    var errorOccurred: ((Error) -> Void)? { get set }
    func loadData()
    func fetchImage(completion: @escaping (UIImage?) -> Void)
}
