//
//  GenresCollectionViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 10/08/2022.
//

import UIKit

protocol GenresCollectionViewCellDelegate: AnyObject {
    func cell(cell: GenresCollectionViewCell, needPerformAtion action: GenresCollectionViewCell.Action)
}

final class GenresCollectionViewCell: UICollectionViewCell {

    enum Action {
        case genresButtonIsSelected
        case genresButtonUnSelected
    }

    // MARK: - IBOutlets
    @IBOutlet private var genresLabel: UILabel!

    // MARK: - Properties
    weak var delegate: GenresCollectionViewCellDelegate?
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

        genresLabel.text = viewModel.genre?.name

        if viewModel.isSelected {
            genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: .bold)
            backgroundColor = .systemOrange
        } else {
            if #available(iOS 13.0, *) {
                backgroundColor = .systemGray5
                genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: .regular)
            } else {
                backgroundColor = .systemGray
                genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: .regular)
            }
        }
    }

    // MARK: - IBAction
    @IBAction private func genresTouchUpInside(_ sender: UIButton) {

        isSelect = !(viewModel?.genre?.isSelect ?? true)
        guard let delegate = delegate else {
            return
        }

        if isSelect {
            genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: Define.boldFont)
            backgroundColor = .systemOrange
            delegate.cell(cell: self, needPerformAtion: .genresButtonIsSelected)
        } else {
            if #available(iOS 13.0, *) {
                backgroundColor = .systemGray5
                genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: Define.regularFont)
            } else {
                backgroundColor = .systemGray
                genresLabel.font = UIFont.systemFont(ofSize: Define.fontSize, weight: Define.regularFont)
            }
            delegate.cell(cell: self, needPerformAtion: .genresButtonUnSelected)
        }
    }
}

// MARK: - Define
extension GenresCollectionViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
        static let fontSize: CGFloat = 14
        static let boldFont: UIFont.Weight = .bold
        static let regularFont: UIFont.Weight = .regular
    }
}
