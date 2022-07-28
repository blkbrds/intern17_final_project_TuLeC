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
        titleLabel.text = "Phim mới nhất"
    }

    private func updateCell() {
        let nib = UINib(nibName: Strings().nowPlayingCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Strings().nowPlayingCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension LatestTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings().nowPlayingCollectionCell, for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.cellForItemAt(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (SizeWithScreen().width - 25) / 2
        return CGSize(width: width, height: width * 0.65)
    }
}
