//
//  DetailCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 18/08/2022.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    // MARK: - Properties
    var viewModel: DetailCollectionCellViewModel?

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    private func configUI() {
        ratingLabel.layer.masksToBounds = Define.labelMasksToBounds
        ratingLabel.layer.cornerRadius = Define.labelCornerRadius
        imageView.layer.cornerRadius = Define.imageCornerRadius
    }
}

extension DetailCollectionViewCell {
    struct Define {
        static let labelMasksToBounds: Bool = true
        static let labelCornerRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 7.5
    }
}
