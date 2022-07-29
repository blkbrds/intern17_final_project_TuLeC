//
//  LatestTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import UIKit

final class LatestTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!

    var viewModel: LatestTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = Define.titleLabel
        configCollectionView()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: Define.nowPlayingCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Define.nowPlayingCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func updateCell() {
    }
}

extension LatestTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.nowPlayingCollectionCell, for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.cellForItemAt()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Define.width, height: Define.width * 0.65)
    }
}

extension LatestTableViewCell {
    struct Define {
        static let width = (SizeWithScreen.shared.width - 25) / 2
        static let nowPlayingCollectionCell: String = "NowPlayingCollectionViewCell"
        static let titleLabel: String = "Phim mới nhất"
    }
}
