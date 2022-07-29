//
//  NowPlayingCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    var viewModel: NowPlayingCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Phim khủng long"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = Define.cornerRadius
    }

    private func updateCell() {
    }
}

extension NowPlayingCollectionViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
    }
}
