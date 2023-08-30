//
//  ListViewModelImpl.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

final class ListViewModelImpl: ListViewModel {

    var listLoaded: (() -> Void)?
    var errorOccurred: ((String) -> Void)?

    private let networkService: NetworkService
    private var data: [AdItem] = []

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getCount() -> Int {
        data.count
    }

    func getItem(for index: Int) -> AdItem? {
        guard data.indices.contains(index) else { return nil }
        return data[index]
    }

    func loadData() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self = self else { return }
            do {
                let list = try await self.networkService.loadAdvertisementsList()

                self.data = list
                if let listLoaded = listLoaded {
                    listLoaded()
                }
            } catch {
                if let errorOccurred = self.errorOccurred {
                    errorOccurred(error.localizedDescription)
                }
            }
        }
    }

    func fetchImage(for index: Int, completion: @escaping (Data) -> Void) -> URLSessionDownloadTask? {
        guard data.indices.contains(index) else { return nil }

        return networkService.getImageData(by: data[index].imageURL) { result in
            switch result {
            case .failure(let error):
                if let errorOccurred = self.errorOccurred {
                    errorOccurred(error.localizedDescription)
                }
            case .success(let data):
                completion(data)
            }
        }
    }

}
