//
//  NowPlayingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class NowPlayingTableCellViewModel {
    private var nowPlaying: [Slider] = []

    func loadAPI(completion: @escaping APICompletion) {
        ApiManager.Video.callHomeApi(type: .nowPlaying) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let data = data, let items = data["results"] as? [JSObject] else { return }
                var arrSlider: [Slider] = []
                for item in items {
                    arrSlider.append(Slider(json: item))
                }
                this.nowPlaying = arrSlider
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        if nowPlaying.count < 10 {
            return nowPlaying.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let item = nowPlaying[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(nowPlaying: item)
        return viewModel
    }
}

extension NowPlayingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
