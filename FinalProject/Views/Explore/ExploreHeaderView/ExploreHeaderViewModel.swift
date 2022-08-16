//
//  ExploreHeaderViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import Foundation

final class ExploreHeaderViewModel {

    // MARK: - Properties
    private var genres: [Genres] = []

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
        return GenresCollectionCellViewModel(genre: item)
    }

    func sizeForItem(at indexPath: IndexPath) -> String {
        return genres[safe: indexPath.row]?.name ?? ""
    }

    func removeData(data: SelectKey, genresKey: [SelectKey]) -> (genresArray: [SelectKey], genresKey: [SelectKey]) {
        var genresKey = genresKey
        var genresArray: [SelectKey] = []
        if data.isSelect {
            genresKey.append(data)
            genresArray = genresKey
            return (genresArray, genresKey)
        } else {
            let index = genresKey.firstIndex { $0.genresId == data.genresId }
            guard let index = index else {
                return ([], [])
            }
            genresKey[index].isSelect = false
            genresArray = genresKey
            genresKey.remove(at: index)
            return (genresArray, genresKey)
        }
    }
}
