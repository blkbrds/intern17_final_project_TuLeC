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

    var viewModel: NowPlayingTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        typeCellLabel.text = "Phim đang chiếu"
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * 0.01)
        let cellHeight = floor(screenSize.height * 0.01)
        let insetX = (self.bounds.width - cellWidth) / 2.0
        let insetY = (self.bounds.height - cellHeight) / 2.0

        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: cellWidth, height: cellHeight)
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
        cell.viewModel = viewModel?.viewForItemAt(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30) / 2
        return CGSize(width: width, height: width * 0.65)
    }
}
