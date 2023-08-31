//
//  ItemCollectionViewCell.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {

    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var createdDateLabel = UILabel()
    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)

    private var downloadTask: URLSessionDownloadTask?

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupTitleLabel()
        setupPriceLabel()
        setupLocationLabel()
        setupCreatedDateLabel()
        setupActivityIndicatorView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
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
        imageView.contentMode = .scaleAspectFit
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

    private func setupActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

}

// MARK: - Configurable

extension ItemCollectionViewCell {

    func configure(with model: AdItem?, and downloadTask: URLSessionDownloadTask?) {
        titleLabel.text = model?.title
        priceLabel.text = model?.price
        locationLabel.text = model?.location
        createdDateLabel.text = model?.createdDate
        activityIndicatorView.startAnimating()
        self.downloadTask = downloadTask
    }

    func configure(with image: UIImage?) {
        activityIndicatorView.stopAnimating()
        imageView.image = image
    }

}

// MARK: - Constants and Fonts

extension ItemCollectionViewCell {

    private struct Constants {
        static let smallMargin: CGFloat = 4
        static let cornerRadius: CGFloat = 6
    }

    private struct Fonts {
        static let regular: UIFont = .systemFont(ofSize: 16)
        static let bold: UIFont = .boldSystemFont(ofSize: 16)
        static let minor: UIFont = .systemFont(ofSize: 13)
    }

}
