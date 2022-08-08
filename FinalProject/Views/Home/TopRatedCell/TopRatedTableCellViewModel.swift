//
//  TopRatedTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class TopRatedTableCellViewModel {
    private var topRated: [Slider] = []
    
    func numberOfItemsInSection() -> Int {
        if topRated.count < 10 {
            return topRated.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let item = topRated[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(nowPlaying: item)
        return viewModel
    }
}

extension TopRatedTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
