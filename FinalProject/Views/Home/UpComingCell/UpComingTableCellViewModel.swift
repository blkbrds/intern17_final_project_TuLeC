//
//  UpComingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class UpComingTableCellViewModel {

    // MARK: - Properties
    var upComing: [Slider]?

    // MARK: - Public functions
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

// MARK: - Define
extension UpComingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
