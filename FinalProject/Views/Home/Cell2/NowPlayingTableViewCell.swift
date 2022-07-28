//
//  NowPlayingTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class NowPlayingTableViewCell: UITableViewCell {

    @IBOutlet private var typeCellLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!

    private let nowPlayingTableCell = NowPlayingTableCell()
    var viewModel: NowPlayingTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        typeCellLabel.text = "Phim đang chiếu"
        let insetY = (self.bounds.height - nowPlayingTableCell.cellHeight) / 2.0

        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: nowPlayingTableCell.cellWidth, height: nowPlayingTableCell.cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: 10, bottom: insetY, right: 10)

    }

    private func updateCell() {
        let nib = UINib(nibName: "NowPlayingCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension NowPlayingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.cellForItemAt(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return nowPlayingTableCell.sizeForItemAt
    }
}

class NowPlayingTableCell {
    var cellWidth: CGFloat
    var cellHeight: CGFloat
    var sizeForItemAt: CGSize

    init() {
        cellWidth = floor(SizeWithScreen().width * 0.01)
        cellHeight = floor(SizeWithScreen().height * 0.01)
        sizeForItemAt = CGSize(width: (SizeWithScreen().width - 30) / 2, height: ((SizeWithScreen().width - 30) / 2) * 0.65)
    }
}
