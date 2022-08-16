//
//  ExploreViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class ExploreViewModel {

    // MARK: - Properties
    private let contentMovies: [ContentMovie]?

    init (contentMovies: [ContentMovie]?) {
        self.contentMovies = contentMovies
    }

    // MARK: - Public functions\
    func numberOfItemsInSection(pageNumber: Int) -> Int {
        return contentMovies?.count ?? 0
    }

    func viewModelForItem(at indexPath: IndexPath) -> ContentMovieCollectionCellViewModel {
        guard let contentMovies = contentMovies,
              let item = contentMovies[safe: indexPath.row] else {
            return ContentMovieCollectionCellViewModel(contentMovie: nil)
        }

        return ContentMovieCollectionCellViewModel(contentMovie: item)
    }

    func viewModelForHeader(data: [Genres]) -> ExploreHeaderViewModel {
        return ExploreHeaderViewModel(genres: data)
    }

    func reloadWhenSelect(data: [SelectKey], genres: [Genres]) -> [SelectKey] {
        var genresKey = data
        for item in data {
            let check = genres.firstIndex { $0.id == item.genresId }
            guard let check = check else {
                return []
            }

            genres[check].isSelect = item.isSelect
            if item.isSelect == false {
                let index = data.firstIndex { $0.isSelect == item.isSelect }
                guard let index = index else {
                    return[]
                }
                genresKey.remove(at: index)
            }
        }
        return genresKey
    }
}
