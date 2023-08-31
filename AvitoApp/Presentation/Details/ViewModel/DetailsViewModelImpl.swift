//
//  DetailsViewModelImpl.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 31.08.2023.
//

import Foundation
import UIKit

final class DetailsViewModelImpl: DetailsViewModel {

    var dataLoaded: ((AdItem) -> Void)?
    var errorOccurred: ((Error) -> Void)?

    private let networkService: NetworkService
    private let itemID: String
    private var data: AdItem?
    
    init(itemID: String, networkService: NetworkService) {
        self.itemID = itemID
        self.networkService = networkService
    }

    func loadData() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self = self else { return }
            do {
                let item = try await self.networkService.getDetails(id: itemID)
                self.data = item
                if let dataLoaded = dataLoaded {
                    dataLoaded(item)
                }
            } catch {
                if let errorOccurred = self.errorOccurred {
                    errorOccurred(error)
                }
            }
        }
    }

    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = data?.imageURL else {
            completion(getPlaceholderImage())
            return
        }

        networkService.getImageData(by: url) { [weak self] result in
            switch result {
            case .failure:
                completion(self?.getPlaceholderImage())
            case .success(let data):
                completion(UIImage(data: data))
            }
        }
    }

    private func getPlaceholderImage() -> UIImage? {
        UIImage(systemName: "photo")?
            .withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }
    
}
