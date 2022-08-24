//
//  ExploreViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class ExploreViewModel {

    // MARK: - Properties
    var contentMovies: [ContentMovie]
    var genres: [Genres] = []
    var genresKeys: [Int] = []

    init(contentMovies: [ContentMovie]) {
        self.contentMovies = contentMovies
    }

    // MARK: - Public functions\
    func numberOfItemsInSection(pageNumber: Int) -> Int {
        return contentMovies.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> ContentMovieCollectionCellViewModel {
        guard let item = contentMovies[safe: indexPath.row] else {
            return ContentMovieCollectionCellViewModel(contentMovie: nil)
        }

        return ContentMovieCollectionCellViewModel(contentMovie: item)
    }

    func viewModelForHeader(data: [Genres]) -> ExploreHeaderViewModel {
        return ExploreHeaderViewModel(genres: data)
    }

    // MARK: - APIs
    func getExploreApi(genresKey: [Int], isCallKey: Bool = true, pageNumber: Int, completion: @escaping Completion<[ContentMovie]>) {
        ApiManager.Discover.getExploreApi(url: ApiManager.Discover.getURL(keys: genresKey, page: pageNumber) ) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                for item in data {
                    this.contentMovies.append(item)
                }
                completion(.success(this.contentMovies))
            case .failure(let error):
                print(error)
            }
        }
    }

    func getGenresApi(completion: @escaping Completion<[Genres]>) {
        ApiManager.Genre.getGenreApi(url: ApiManager.Genre.getURL()) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.genres = data
                completion(.success(this.genres))
            case .failure(let error):
                print(error)
            }
        }
    }

    func viewModelForDetail(indexPath: IndexPath) -> DetailViewModel {
        guard let id = contentMovies[indexPath.row].id,
              let overview = contentMovies[indexPath.row].overview,
              let originalTitle = contentMovies[indexPath.row].originalTitle,
              let genres = contentMovies[indexPath.row].genres else {
            return DetailViewModel(id: 0, originalTitle: "", overview: "", genres: [])
        }
        return DetailViewModel(id: id, originalTitle: originalTitle, overview: overview, genres: genres)
    }
}
