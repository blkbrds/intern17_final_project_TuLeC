//
//  SliderCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit
import SVProgressHUD

final class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    var viewModel: SliderCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.slider.originalTitle

        if let image = viewModel.slider.image {
            self.imageView.image = image
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
              let backdropPath = viewModel.slider.backdropPath else {
            return
        }
        imageView.downloadImage(url: ApiManager.Path.imageURL + backdropPath) { image in
            if let image = image {
                viewModel.slider.image = image
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
