//
//  NowPlayingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class NowPlayingTableCellViewModel {

    func numberOfItemsInSection() -> Int {
        return Define.numberOfItemsInSection
    }

    func viewModelForItem() -> NowPlayingCollectionCellViewModel {
        let viewModel = NowPlayingCollectionCellViewModel()
        return viewModel
    }
}

extension NowPlayingTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
