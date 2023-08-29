//
//  Configurable.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import Foundation

protocol Configurable: AnyObject {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
