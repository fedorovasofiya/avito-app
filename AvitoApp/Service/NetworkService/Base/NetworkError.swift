//
//  NetworkError.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

enum NetworkError: Error {
    case wrongURL(URLComponents)
    case unexpectedResponse
    case redirect
    case badRequest
    case serverError
    case unexpectedStatusCode(Int)
    case noData
    case invalidURLString(String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wrongURL(let urlComponents):
            return "Could not construct url with components: \(urlComponents)"
        case .unexpectedResponse:
            return "Unexpected response from server"
        case .redirect:
            return "Redirect"
        case .badRequest:
            return "Wrong request"
        case .serverError:
            return "Server error"
        case .unexpectedStatusCode(let code):
            return "Unexpected status code: \(code)"
        case .noData:
            return "No data"
        case .invalidURLString(let string):
            return "Can't create URL from string: \(string)"
        }
    }
}
