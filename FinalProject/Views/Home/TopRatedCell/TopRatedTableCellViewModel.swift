//
//  TopRatedTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class TopRatedTableCellViewModel {

    // MARK: - Properties
    var topRated: [Slider]?

    // MARK: - Public functions
    func loadAPI(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getTopRated()

        ApiManager.Movie.getHomeApi(url: url) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let data):
                this.topRated = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        guard let topRated = topRated else {
            return 0
        }

        if topRated.count < Define.numberOfItemsInSection {
            return topRated.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        guard let topRated = topRated else {
            return NowPlayingCollectionCellViewModel(slider: nil)
        }

        let item = topRated[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(slider: item)
        return viewModel
    }
}

// MARK: - Define
extension TopRatedTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
