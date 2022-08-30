//
//  SearchContentTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 23/08/2022.
//

import UIKit

final class SearchContentTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    var viewModel: SearchContentViewModel? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.cornerRadius = Define.cornerRadius
    }

    private func updateUI() {
        guard let viewModel = viewModel,
              let title = viewModel.searchContents?.originalTitle else {
            return
        }
        
        titleLabel.text = title
    }
}

extension SearchContentTableViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
    }
}
