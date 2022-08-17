//
//  ExploreHeaderViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import Foundation

final class ExploreHeaderViewModel {

    // MARK: - Properties
    var genres: [Genres] = []

    init (genres: [Genres]) {
        self.genres = genres
    }

    // MARK: - Public functions
    func numberOfItemsInSection() -> Int {
        return genres.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> GenresCollectionCellViewModel {
        guard let item = genres[safe: indexPath.row] else {
            return GenresCollectionCellViewModel(genre: nil)
        }

        return GenresCollectionCellViewModel(genre: item, isSelected: item.isSelect)
    }

    func sizeForItem(at indexPath: IndexPath) -> String {
        return genres[safe: indexPath.row]?.name ?? ""
    }
}
