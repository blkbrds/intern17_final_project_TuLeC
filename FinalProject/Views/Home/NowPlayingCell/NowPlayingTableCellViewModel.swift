//
//  NowPlayingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class NowPlayingTableCellViewModel {

    private var nowPlayings: [Slider]?

    func loadAPI(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getNowPlayingURL()
        
        ApiManager.Movie.getHomeApi(url: url) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let data):
                this.nowPlayings = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        guard let nowPlayings = nowPlayings else {
            return 0
        }

        if nowPlayings.count < Define.numberOfItemsInSection {
            return nowPlayings.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        guard let nowPlayings = nowPlayings else {
            return NowPlayingCollectionCellViewModel(slider: nil)
        }

        let item = nowPlayings[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(slider: item)
        return viewModel
    }
}

extension NowPlayingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
