//
//  LatestTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class LatestTableCellViewModel {
    private var latest: [Slider] = []

    func numberOfItemsInSection() -> Int {
        if latest.count < 10 {
            return latest.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let item = latest[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(nowPlaying: item)
        return viewModel
    }
}

extension LatestTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
