//
//  ExploreHeaderViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import Foundation

final class ExploreHeaderViewModel {

    // MARK: - Properties
    #warning("dummy data")
    private var genres = ["Action", "Adventure", "Animation",
                       "Comedy", "Crime", "Documentary", "Drama",
                       "Family", "Fantasy", "History", "Horror", "Music",
                       "Mystery", "Romance", "Science Fiction", "TV Movie",
                       "Thriller", "War", "Western"]

    // MARK: - Public functions
    func numberOfItemsInSection() -> Int {
        return genres.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> GenresCollectionCellViewModel {
        guard let item = genres[safe: indexPath.row] else {
            return GenresCollectionCellViewModel(genre: nil)
        }
        return GenresCollectionCellViewModel(genre: item)
    }

    func sizeForItem(at indexPath: IndexPath) -> String {
        return genres[safe: indexPath.row] ?? ""
    }
}
