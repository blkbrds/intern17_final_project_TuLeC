//
//  ExploreViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class ExploreViewModel {

    // MARK: - Properties
    var contentMoviesSlider: [Slider]
    var genres: [Genres] = []
    var genresKeys: [Int] = []

    init(contentMoviesSlider: [Slider]) {
        self.contentMoviesSlider = contentMoviesSlider
    }

    // MARK: - Public functions\
    func numberOfItemsInSection(pageNumber: Int) -> Int {
        return contentMoviesSlider.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> ContentMovieCollectionCellViewModel {
        guard let item = contentMoviesSlider[safe: indexPath.row] else {
            return ContentMovieCollectionCellViewModel(contentMovieSlider: nil)
        }

        return ContentMovieCollectionCellViewModel(contentMovieSlider: item)
    }

    func viewModelForHeader(data: [Genres]) -> ExploreHeaderViewModel {
        return ExploreHeaderViewModel(genres: data)
    }

    // MARK: - APIs
    func getExploreApi(genresKey: [Int], isCallKey: Bool = true, pageNumber: Int, completion: @escaping Completion<[Slider]>) {
        ApiManager.Discover.getExploreApi(url: ApiManager.Discover.getURL(keys: genresKey, page: pageNumber) ) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                for item in data {
                    this.contentMoviesSlider.append(item)
                }
                completion(.success(this.contentMoviesSlider))
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
        return DetailViewModel(detail: contentMoviesSlider[indexPath.row])
    }
}
