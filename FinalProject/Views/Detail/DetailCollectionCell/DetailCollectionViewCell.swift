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
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!

    // MARK: - Properties
    // MARK: - Properties
    var viewModel: DetailCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    private func configUI() {
        ratingLabel.layer.masksToBounds = Define.labelMasksToBounds
        ratingLabel.layer.cornerRadius = Define.labelCornerRadius
        imageView.layer.cornerRadius = Define.imageCornerRadius
    }

    private func updateCell() {
        guard let viewModel = viewModel,
              let voteAverage = viewModel.detail?.voteAverage else {
            return
        }
        titleLabel.text = viewModel.detail?.originalTitle
        ratingLabel.text = "\(voteAverage)"
        overviewLabel.text = viewModel.detail?.overview
        if let image = viewModel.detail?.image {
            imageView.image = image
        } else {
            imageView.downloadImage(url: ApiManager.Path.imageURL + (viewModel.detail?.backdropPath ?? "")) { image in
                if let image = image {
                    viewModel.detail?.image = image
                    self.imageView.image = image
                } else {
                    self.imageView.image = nil
                }
            }
        }
    }
}

extension DetailCollectionViewCell {
    struct Define {
        static let labelMasksToBounds: Bool = true
        static let labelCornerRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 7.5
    }
}
