//
//  NowPlayingCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class NowPlayingCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - Properties
    var viewModel: NowPlayingCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Phim khủng long"
    }

    // MARK: - Override functions
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = Define.cornerRadius
    }

    // MARK: - Private functions
    private func updateCell() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.slider?.originalTitle

        if let image = viewModel.slider?.image {
            imageView.image = image
        } else {
            downloadImageForRow {[weak self] image in
                guard let this = self else { return }
                if let image = image {
                    this.imageView.image = image
                } else {
                    this.imageView.image = nil
                }
            }
        }
    }

    private func downloadImageForRow(completion: @escaping (UIImage?) -> Void) {
        guard let viewModel = viewModel,
              let backdropPath = viewModel.slider?.backdropPath else {
            return
        }
        imageView.downloadImage(url: ApiManager.Path.imageURL + backdropPath) { image in
            if let image = image {
                viewModel.slider?.image = image
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}

// MARK: - Define
extension NowPlayingCollectionViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
    }
}
