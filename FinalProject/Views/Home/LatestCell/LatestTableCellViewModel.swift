//
//  LatestTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class LatestTableCellViewModel {
    private var latest: [Slider]?

    func loadAPI(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getLatest()

        ApiManager.Movie.getHomeApi(url: url) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let data):
                this.latest = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        guard let latest = latest else {
            return 0
        }

        if latest.count < Define.numberOfItemsInSection {
            return latest.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        guard let latest = latest else {
            return NowPlayingCollectionCellViewModel(slider: nil)
        }

        let item = latest[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(slider: item)
        return viewModel
    }
}

extension LatestTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
