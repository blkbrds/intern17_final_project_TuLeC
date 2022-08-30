//
//  SearchContentTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 23/08/2022.
//

import UIKit

final class SearchContentTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentImageView: UIImageView!

    var viewModel: SearchContentViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.cornerRadius = Define.cornerRadius
    }
}

extension SearchContentTableViewCell {
    struct Define {
        static let cornerRadius: CGFloat = 10
    }
}
