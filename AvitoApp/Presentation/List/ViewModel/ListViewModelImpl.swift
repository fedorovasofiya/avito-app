//
//  ListViewModelImpl.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation
import UIKit

final class ListViewModelImpl: ListViewModel {

    var listLoaded: (() -> Void)?
    var errorOccurred: ((Error) -> Void)?
    var detailsTapped: ((UIViewController) -> Void)?

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
                    errorOccurred(error)
                }
            }
        }
    }

    func fetchImage(for index: Int, completion: @escaping (UIImage?) -> Void) -> URLSessionDownloadTask? {
        guard data.indices.contains(index) else {
            completion(getPlaceholderImage())
            return nil
        }

        return networkService.getImageData(by: data[index].imageURL) { [weak self] result in
            switch result {
            case .failure(let error):
                if let error = error as? URLError,
                   error.code != .cancelled {
                    completion(self?.getPlaceholderImage())
                }
            case .success(let data):
                completion(UIImage(data: data))
            }
        }
    }

    func didTapItem(with index: Int) {
        guard data.indices.contains(index),
              let detailsTapped = detailsTapped
        else { return }

        let viewModel = DetailsViewModelImpl(itemID: data[index].id, networkService: networkService)
        let viewControllerToDisplay = DetailsViewController(viewModel: viewModel)
        detailsTapped(viewControllerToDisplay)
    }

    private func getPlaceholderImage() -> UIImage? {
        UIImage(systemName: "photo")?
            .withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }
    
}
