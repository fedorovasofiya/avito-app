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

    // MARK: - Private Methods

    private func makeURL(path: String) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Configuration.scheme
        urlComponents.host = Configuration.host
        urlComponents.path = path

        guard let url = urlComponents.url else {
            throw RequestError.wrongURL(urlComponents)
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
            throw RequestError.unexpectedResponse
        }
        try handleStatusCode(response: response)
        return (data, response)
    }

    private func handleStatusCode(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 100 ... 299:
            return
        case 400:
            throw RequestError.badRequest
        case 401:
            throw RequestError.wrongAuth
        case 404:
            throw RequestError.notFound
        case 500 ... 599:
            throw RequestError.serverError
        default:
            throw RequestError.unexpectedStatusCode(response.statusCode)
        }
    }

}
