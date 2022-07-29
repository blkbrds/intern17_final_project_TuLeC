//
//  UpComingTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import UIKit

final class UpComingTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!

    var viewModel: UpComingTableCellViewModel? {
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    private func updateCell() {
    }
}

extension UpComingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return Define.sizeForItemAt
    }
}

extension UpComingTableViewCell {
    struct Define {
        static let sizeForItemAt: CGSize = CGSize(width: (SizeWithScreen.shared.width - 30) / 2, height: ((SizeWithScreen.shared.width - 30) / 2) * 0.65)
        static let nowPlayingCollectionCell: String = "NowPlayingCollectionViewCell"
        static let titleLabel: String = "Sắp chiếu"
    }
}
