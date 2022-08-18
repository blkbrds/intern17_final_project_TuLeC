//
//  HeaderCollectionReusableView.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {

    // MARK: - IBOutlets
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: HeaderViewViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    // MARK: - Private functions
    private func updateCell() {
        collectionView.reloadData()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: Define.nib, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Define.nib)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Delegate, Datasource
extension HeaderCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.nib, for: indexPath) as? TagsCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

}

// MARK: - DelegateFlowLayout
extension HeaderCollectionReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else {
            return CGSize(width: 0, height: 0)
        }
        let cellWidth = viewModel.sizeForItem(at: indexPath).size(withAttributes: [.font: UIFont.systemFont(ofSize: 10.0)]).width + 30.0
        return CGSize(width: cellWidth, height: Define.height)
    }
}

// MARK: - Define
extension HeaderCollectionReusableView {
    struct Define {
        static let nib: String = "TagsCollectionViewCell"
        static let height: CGFloat = 20
    }
}
