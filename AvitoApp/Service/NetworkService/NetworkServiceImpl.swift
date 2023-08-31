//
//  NetworkServiceImpl.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

final class NetworkServiceImpl: NetworkService {

    private struct Configuration {
        static let scheme = "https"
        static let host = "www.avito.st"
        static let path = "/s/interns-ios"
    }

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func loadAdvertisementsList() async throws -> [AdItem] {
        let request = try makeGetRequest(path: "\(Configuration.path)/main-page.json")
        let (data, _) = try await performRequest(request)
        let response = try JSONDecoder().decode(ListDTO.self, from: data)
        return response.advertisements.map {
            AdItem(
                id: $0.id,
                imageURL: $0.image_url,
                title: $0.title,
                price: $0.price,
                location: $0.location,
                createdDate: AdItem.formatDate(from: $0.created_date)
            )
        }
    }

    func getDetails(id: String) async throws -> AdItem {
        let request = try makeGetRequest(path: "\(Configuration.path)/details/\(id).json")
        let (data, _) = try await performRequest(request)
        let response = try JSONDecoder().decode(AdvertisementDTO.self, from: data)
        return AdItem(
            id: response.id,
            imageURL: response.image_url,
            title: response.title,
            price: response.price,
            location: response.location,
            createdDate: AdItem.formatDate(from: response.created_date),
            description: response.description,
            email: response.email,
            phoneNumber: response.phone_number,
            address: response.address
        )
    }

    @discardableResult
    func getImageData(by urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDownloadTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURLString(urlString)))
            return nil
        }

        let downloadTask = urlSession.downloadTask(with: url) { url, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let url,
                  let data = try? Data(contentsOf: url)
            else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }

        downloadTask.resume()
        return downloadTask
    }

    // MARK: - Private Methods

    private func makeURL(path: String) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Configuration.scheme
        urlComponents.host = Configuration.host
        urlComponents.path = path

        guard let url = urlComponents.url else {
            throw NetworkError.wrongURL(urlComponents)
        }
        return url
    }

    private func makeGetRequest(path: String) throws -> URLRequest {
        let url = try makeURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    private func performRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await urlSession.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedResponse
        }
        try handleStatusCode(response: response)
        return (data, response)
    }

    private func handleStatusCode(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 100 ... 299:
            return
        case 300 ... 399:
            throw NetworkError.redirect
        case 400 ... 499:
            throw NetworkError.badRequest
        case 500 ... 599:
            throw NetworkError.serverError
        default:
            throw NetworkError.unexpectedStatusCode(response.statusCode)
        }
    }

}
