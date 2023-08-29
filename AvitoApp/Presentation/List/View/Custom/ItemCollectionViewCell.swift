//
//  ItemCollectionViewCell.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {

    struct DisplayData {
        let id: String
        let image: UIImage?
        let title: String
        let price: String
        let location: String
        let createdDate: String
    }

    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var createdDateLabel = UILabel()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupTitleLabel()
        setupPriceLabel()
        setupLocationLabel()
        setupCreatedDateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        createdDateLabel.text = nil
    }

    // MARK: - UI Setup

    private func setupImageView() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.font = Fonts.regular
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.smallMargin)
        ])
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.bold
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.smallMargin)
        ])
    }

    private func setupLocationLabel() {
        locationLabel.textColor = .gray
        locationLabel.font = Fonts.minor
        locationLabel.numberOfLines = 1
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)

        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Constants.smallMargin)
        ])
    }

    private func setupCreatedDateLabel() {
        createdDateLabel.textColor = .gray
        createdDateLabel.font = Fonts.minor
        createdDateLabel.numberOfLines = 1
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(createdDateLabel)

        NSLayoutConstraint.activate([
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor)
        ])
    }

}

// MARK: - Configurable

extension ItemCollectionViewCell: Configurable {
    func configure(with model: DisplayData) {
        imageView.image = model.image
        titleLabel.text = model.title
        priceLabel.text = model.price
        locationLabel.text = model.location
        createdDateLabel.text = model.createdDate
    }
}
