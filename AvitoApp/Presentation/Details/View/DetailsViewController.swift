//
//  DetailsViewController.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var priceLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var addressLabel = UILabel()
    private lazy var descriptionHeaderLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var contactsHeaderLabel = UILabel()
    private lazy var emailLabel = UILabel()
    private lazy var phoneLabel = UILabel()
    private lazy var idLabel = UILabel()
    private lazy var createdDateLabel = UILabel()
    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)

    private var viewModel: DetailsViewModel

    // MARK: - Lifecycle

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupContentView()
        setupImageView()
        setupPriceLabel()
        setupTitleLabel()
        setupLocationLabel()
        setupAddressLabel()
        setupDescriptionHeaderLabel()
        setupDescriptionLabel()
        setupContactsHeaderLabel()
        setupEmailLabel()
        setupPhoneLabel()
        setupIDLabel()
        setupCreatedDateLabel()
        setupActivityIndicatorView()

        bindViewModel()
        viewModel.loadData()
    }

    // MARK: - UI Setup

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupImageView() {
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.boldTitle
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.margin)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.font = Fonts.title
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor)
        ])
    }

    private func setupLocationLabel() {
        locationLabel.font = Fonts.regular
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)

        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.margin)
        ])
    }

    private func setupAddressLabel() {
        addressLabel.font = Fonts.regular
        addressLabel.numberOfLines = 0
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor)
        ])
    }

    private func setupDescriptionHeaderLabel() {
        descriptionHeaderLabel.text = Strings.descriptionHeader
        descriptionHeaderLabel.font = Fonts.boldTitle
        descriptionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionHeaderLabel)

        NSLayoutConstraint.activate([
            descriptionHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            descriptionHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            descriptionHeaderLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: Constants.bigMargin)
        ])
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = Fonts.regular
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: Constants.margin)
        ])
    }

    private func setupContactsHeaderLabel() {
        contactsHeaderLabel.text = Strings.contactsHeader
        contactsHeaderLabel.font = Fonts.boldTitle
        contactsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contactsHeaderLabel)

        NSLayoutConstraint.activate([
            contactsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            contactsHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            contactsHeaderLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.bigMargin)
        ])
    }

    private func setupEmailLabel() {
        emailLabel.font = Fonts.regular
        emailLabel.numberOfLines = 0
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)

        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            emailLabel.topAnchor.constraint(equalTo: contactsHeaderLabel.bottomAnchor, constant: Constants.margin)
        ])
    }

    private func setupPhoneLabel() {
        phoneLabel.font = Fonts.regular
        phoneLabel.numberOfLines = 0
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phoneLabel)

        NSLayoutConstraint.activate([
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor)
        ])
    }

    private func setupIDLabel() {
        idLabel.textColor = .gray
        idLabel.font = Fonts.minor
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)

        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            idLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: Constants.bigMargin)
        ])
    }

    private func setupCreatedDateLabel() {
        createdDateLabel.textColor = .gray
        createdDateLabel.font = Fonts.minor
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(createdDateLabel)

        NSLayoutConstraint.activate([
            createdDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.margin),
            createdDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            createdDateLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor),
            createdDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bigMargin)
        ])
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel.dataLoaded = { [weak self] item in
            DispatchQueue.main.async {
                self?.titleLabel.text = item.title
                self?.priceLabel.text = item.price
                self?.locationLabel.text = item.location
                self?.createdDateLabel.text = item.createdDate
                self?.descriptionLabel.text = item.description
                self?.emailLabel.text = item.email
                self?.phoneLabel.text = item.phoneNumber
                self?.addressLabel.text = item.address
                self?.idLabel.text = Strings.idPrefix + item.id
            }
            self?.viewModel.fetchImage(completion: { image in
                DispatchQueue.main.async {
                    self?.activityIndicatorView.stopAnimating()
                    self?.imageView.image = image
                }
            })
        }
        viewModel.errorOccurred = { error in
            print(error) // TODO
        }
    }

}

// MARK: - Constants, Fonts and Strings

extension DetailsViewController {

    private struct Constants {
        static let margin: CGFloat = 16
        static let bigMargin: CGFloat = 32
    }

    private struct Fonts {
        static let regular: UIFont = .systemFont(ofSize: 16)
        static let minor: UIFont = .systemFont(ofSize: 13)
        static let title: UIFont = .systemFont(ofSize: 24)
        static let boldTitle: UIFont = .boldSystemFont(ofSize: 25)
    }

    private struct Strings {
        static let descriptionHeader: String = "Описание"
        static let contactsHeader: String = "Контакты"
        static let idPrefix: String = "Объявление №"
    }

}
