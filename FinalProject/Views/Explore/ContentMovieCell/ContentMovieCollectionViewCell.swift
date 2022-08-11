//
//  ContentMovieCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 10/08/2022.
//

import UIKit

final class ContentMovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - Properties
    var viewModel: ContentMovieCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Private functions
    private func configUI() {
        imageView.layer.cornerRadius = Define.cornerRadius
    }

    private func updateCell() {
        guard let viewModel = viewModel,
              let rating = viewModel.contenMovie?.voteAverage else {
            return
        }

        ratingLabel.text = "\(String(describing: rating))"
        titleLabel.text = viewModel.contenMovie?.originalTitle
    }
}

// MARK: - Define
extension ContentMovieCollectionViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
    }
}
