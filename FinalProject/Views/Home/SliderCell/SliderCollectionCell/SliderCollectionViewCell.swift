//
//  SliderCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!

    var viewModel: SliderCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
    }
}
