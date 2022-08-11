//
//  GenresCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 10/08/2022.
//

import UIKit

final class GenresCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var genresLabel: UILabel!

    // MARK: - Properties
    private var isSelect: Bool = false
    var viewModel: GenresCollectionCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Define.cornerRadius
    }

    // MARK: - Private functions
    private func updateCell() {
        guard let viewModel = viewModel else {
            return
        }

        genresLabel.text = viewModel.genre
    }

    // MARK: - IBAction
    @IBAction private func genresTouchUpInside(_ sender: UIButton) {
        isSelect = !isSelect
        if isSelect {
            genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: .bold)
            backgroundColor = .systemOrange
        } else {
            if #available(iOS 13.0, *) {
                backgroundColor = .systemGray5
                genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: .regular)
            }
        }
    }
}

// MARK: - Define
extension GenresCollectionViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
        static let fontSize: CGFloat = 14
    }
}
