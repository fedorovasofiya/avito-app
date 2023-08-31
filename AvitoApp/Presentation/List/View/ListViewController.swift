//
//  ListViewController.swift
//  AvitoApp
//
//  Created by Sonya Fedorova on 29.08.2023.
//

import UIKit

final class ListViewController: UIViewController {

    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)
    private lazy var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Constants.margin
        flowLayout.minimumInteritemSpacing = Constants.margin
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()

    private var viewModel: ListViewModel
    private var state: ScreenState = .loading {
        didSet {
            DispatchQueue.main.async {
                switch self.state {
                case .loading:
                    self.activityIndicatorView.startAnimating()
                case .data:
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView.reloadData()
                case .error(let message):
                    self.activityIndicatorView.stopAnimating()
                    self.presentAlert(with: message)
                }
            }
        }
    }

    // MARK: - Lifecycle

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.title
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupActivityIndicatorView()

        bindViewModel()
        state = .loading
        viewModel.loadData()
    }

    // MARK: - UI Setup

    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ItemCollectionViewCell.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel.listLoaded = { [weak self] in
            self?.state = .data
        }
        viewModel.detailsTapped = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        viewModel.errorOccurred = { [weak self] error in
            self?.state = .error(error.localizedDescription)
        }
    }

    private func presentAlert(with message: String) {
        let alertController = UIAlertController(title: Strings.alertErrorTitle, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Strings.tryAgainAction, style: .default, handler: { [weak self] _ in
            self?.state = .loading
            self?.viewModel.loadData()
        }))
        self.present(alertController, animated: true)
    }

}

// MARK: - UICollectionViewDataSource

extension ListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }

        let downloadTask = self.viewModel.fetchImage(for: indexPath.row) { image in
            DispatchQueue.main.async {
                cell.configure(with: image)
            }
        }
        let item = viewModel.getItem(for: indexPath.row)

        cell.configure(with: item, and: downloadTask)
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension ListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapItem(with: indexPath.row)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - Constants.margin * 3) / 2
        return CGSize(width: width, height: Constants.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: Constants.margin, left: Constants.margin, bottom: Constants.margin, right: Constants.margin)
    }

}

// MARK: - Constants, Strings

extension ListViewController {

    private struct Constants {
        static let margin: CGFloat = 10
        static let cellHeight: CGFloat = 290
    }

    private struct Strings {
        static let title: String = "Список товаров"
        static let alertErrorTitle: String = "Что-то пошло не так..."
        static let tryAgainAction: String = "Попробовать снова"
    }

}
