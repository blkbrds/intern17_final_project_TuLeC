//
//  UpComingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class UpComingTableCellViewModel {

    // MARK: - Properties
    private var upComings: [Slider]?

    init (upComings: [Slider]) {
        self.upComings = upComings
    }

    // MARK: - Public functions
    func numberOfItemsInSection() -> Int {
        guard let upComings = upComings else {
            return 0
        }

        if upComings.count < Define.numberOfItemsInSection {
            return upComings.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        guard let upComings = upComings else {
            return NowPlayingCollectionCellViewModel(slider: nil)
        }
        if upComings.count - 1 < indexPath.row { return NowPlayingCollectionCellViewModel(slider: nil) }
        let item = upComings[indexPath.row]
        let viewModel = NowPlayingCollectionCellViewModel(slider: item)
        return viewModel
    }
}

// MARK: - Define
extension UpComingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
