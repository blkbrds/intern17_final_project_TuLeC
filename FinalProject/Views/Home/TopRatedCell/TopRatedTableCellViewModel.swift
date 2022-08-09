//
//  TopRatedTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class TopRatedTableCellViewModel {

    // MARK: - Properties
    private var topRated: [Slider]?

    init (topRated: [Slider]) {
        self.topRated = topRated
    }

    // MARK: - Public functions
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
        if topRated.count - 1 < indexPath.row { return NowPlayingCollectionCellViewModel(slider: nil) }
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
