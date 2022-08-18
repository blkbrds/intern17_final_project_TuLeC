//
//  HeaderViewViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import Foundation

final class HeaderViewViewModel {

    // MARK: - Properties
    #warning("dummy data")
    private var tags = ["Action", "Adventure"]

    // MARK: - Public functions
    func numberOfItemsInSection() -> Int {
        return tags.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> TagsCollectionCellViewModel {
        guard let item = tags[safe: indexPath.row] else {
            return TagsCollectionCellViewModel(tag: nil)
        }
        return TagsCollectionCellViewModel(tag: item)
    }

    func sizeForItem(at indexPath: IndexPath) -> String {
        return tags[safe: indexPath.row] ?? ""
    }

}
