//
//  ListViewModel.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

protocol ListViewModel {
    var listLoaded: (() -> Void)? { get set }
    var errorOccurred: ((String) -> Void)? { get set }
    func getCount() -> Int
    func getItem(for index: Int) -> AdItem?
    func loadData()
    func fetchImage(for index: Int, completion: @escaping (Data) -> Void) -> URLSessionDownloadTask?
}
