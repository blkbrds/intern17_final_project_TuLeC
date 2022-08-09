//
//  UpComingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class UpComingTableCellViewModel {
    private var upComing: [Slider]?

    func loadAPI(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getUpComing()

        ApiManager.Movie.getHomeApi(url: url) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let data):
                this.upComing = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        guard let upComing = upComing else {
            return 0
        }

        if upComing.count < Define.numberOfItemsInSection {
            return upComing.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        guard let upComing = upComing else {
            return NowPlayingCollectionCellViewModel(slider: nil)
        }

        let item = upComing[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(slider: item)
        return viewModel
    }
}

extension UpComingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
