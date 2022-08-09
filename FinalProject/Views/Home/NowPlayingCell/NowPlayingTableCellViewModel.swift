//
//  NowPlayingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class NowPlayingTableCellViewModel {

    // MARK: - Properties
    var nowPlayings: [Slider]?

    // MARK: - Public functions
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

// MARK: - Define
extension NowPlayingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
