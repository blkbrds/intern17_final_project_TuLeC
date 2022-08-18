//
//  DetailViewController.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import UIKit
import youtube_ios_player_helper

final class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private var playerView: YTPlayerView!
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: DetailViewModel = DetailViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: - Private functions
    private func configUI() {
        playerView.delegate = self
        playerView.webView?.backgroundColor = .black
        playerView.webView?.isOpaque = false
        configNavigationBar()
        configCollectionView()
        tabBarController?.tabBar.isHidden = true
    }

    private func configCollectionView() {
        configNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configNib() {
        let headerNib = UINib(nibName: Define.headerNib, bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Define.headerNib)
        let cellNib = UINib(nibName: Define.cellNib, bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellNib)
    }

    private func configNavigationBar() {
        let backButton = UIButton()
        if #available(iOS 13.0, *) {
            backButton.setImage(Define.systemImage, for: .normal)
        }
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)

        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftItem
    }

    // MARK: - Objc functions
    @objc private func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Delegate, Datasource
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellNib, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        default:
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Define.headerNib, for: indexPath) as? HeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            cell.frame = Define.frameForHeader
            cell.viewModel = viewModel.viewModelForHeader()
            return cell
        }
    }
}

// MARK: - DelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Define.sizeForHeader
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Define.sizeForItem
    }
}

// MARK: - YTPlayerDelegate
extension DetailViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
}

// MARK: - Define
extension DetailViewController {
    struct Define {
        static let headerNib: String = "HeaderCollectionReusableView"
        static let cellNib: String = "DetailCollectionViewCell"
        @available(iOS 13.0, *)
        static let systemImage = UIImage(systemName: "chevron.backward")
        static let frameForHeader = CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width, height: 200)
        static let sizeForHeader = CGSize(width: SizeWithScreen.shared.width, height: 200)
        static let sizeForItem = CGSize(width: SizeWithScreen.shared.width, height: 130)
    }
}
