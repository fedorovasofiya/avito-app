//
//  NetworkService.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

protocol NetworkService {
    func loadAdvertisementsList() async throws -> [AdItem]
    func getDetails(id: String) async throws -> AdItem
    @discardableResult
    func getImageData(by urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDownloadTask?
}
