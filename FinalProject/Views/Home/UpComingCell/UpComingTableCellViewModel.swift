//
//  UpComingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class UpComingTableCellViewModel {
    private var upComing: [Slider] = []

    func numberOfItemsInSection() -> Int {
        if upComing.count < 10 {
            return upComing.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let item = upComing[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(nowPlaying: item)
        return viewModel
    }
}

extension UpComingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
