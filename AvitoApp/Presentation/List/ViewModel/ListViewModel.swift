//
//  ListViewModel.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation
import UIKit

protocol ListViewModel {
    var listLoaded: (() -> Void)? { get set }
    var detailsTapped: ((UIViewController) -> Void)? { get set }
    var errorOccurred: ((Error) -> Void)? { get set }
    func getCount() -> Int
    func getItem(for index: Int) -> AdItem?
    func loadData()
    func fetchImage(for index: Int, completion: @escaping (UIImage?) -> Void) -> URLSessionDownloadTask?
    func didTapItem(with index: Int)
}
