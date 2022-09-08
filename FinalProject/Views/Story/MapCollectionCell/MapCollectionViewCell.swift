//
//  MapCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 01/09/2022.
//

import UIKit

final class MapCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    var viewModel: MapCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    private func updateCell() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.map?.name
        addressLabel.text = viewModel.map?.location?.formattedAddress
    }

}
