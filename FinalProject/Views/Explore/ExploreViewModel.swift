//
//  ExploreViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class ExploreViewModel {

    // MARK: - Properties
    #warning("Dummy data")
    private let contentMovies: [ContentMovie] = [ContentMovie(id: 12, originalTitle: "Doctor Strange", voteAverage: 7.3)]
    // MARK: - Public functions
    func numberOfItemsInSection(page: Int) -> Int {
        return contentMovies.count
    }

    func viewModelForItem() -> ContentMovieCollectionCellViewModel {
        return ContentMovieCollectionCellViewModel(contentMovie: contentMovies.first)
    }

    func viewModelForHeader() -> ExploreHeaderViewModel {
        return ExploreHeaderViewModel()
    }
}
