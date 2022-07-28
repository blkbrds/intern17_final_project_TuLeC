//
//  TopRatedTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import UIKit

final class TopRatedTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!

    private let topRatedTableCell = TopRatedTableCell()
    var viewModel: TopRatedTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Top rated"
        let insetY = (self.bounds.height - topRatedTableCell.cellHeight) / 2.0

        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: topRatedTableCell.cellWidth, height: topRatedTableCell.cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: 10, bottom: insetY, right: 10)
    }

    private func updateCell() {
        let nib = UINib(nibName: Strings().nowPlayingCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Strings().nowPlayingCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TopRatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return topRatedTableCell.sizeForItemAt
    }
}

struct TopRatedTableCell {
    var cellWidth: CGFloat
    var cellHeight: CGFloat
    var sizeForItemAt: CGSize
    init() {
        cellWidth = floor(SizeWithScreen().width * 0.01)
        cellHeight = floor(SizeWithScreen().height * 0.01)
        sizeForItemAt = CGSize(width: ((SizeWithScreen().width - 30) / 2) * 0.65, height: (SizeWithScreen().width - 30) / 2)
    }
}
