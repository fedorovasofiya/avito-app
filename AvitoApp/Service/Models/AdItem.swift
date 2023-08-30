//
//  AdItem.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 30.08.2023.
//

import Foundation

struct AdItem {
    let id: String
    let imageURL: String
    let title: String
    let price: String
    let location: String
    let createdDate: String
    let description: String?
    let email: String?
    let phoneNumber: String?
    let address: String?

    init(
        id: String,
        imageURL: String,
        title: String,
        price: String,
        location: String,
        createdDate: String,
        description: String? = nil,
        email: String? = nil,
        phoneNumber: String? = nil,
        address: String? = nil
    ) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.price = price
        self.location = location
        self.createdDate = createdDate
        self.description = description
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
    }
}

extension AdItem {
    static func formatDate(from string: String) -> String {
        return string
    }
}
