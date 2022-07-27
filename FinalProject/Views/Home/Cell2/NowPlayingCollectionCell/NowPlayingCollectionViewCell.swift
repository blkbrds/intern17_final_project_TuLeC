//
//  NowPlayingCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var image: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    var viewModel: NowPlayingCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    private func configUI() {
        titleLabel.text = "Phim khủng long"
        image.layer.cornerRadius = 10
    }

    private func updateCell() {
    }
}
