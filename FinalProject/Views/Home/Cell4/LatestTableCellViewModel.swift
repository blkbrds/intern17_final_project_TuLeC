//
//  LatestTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class LatestTableCellViewModel {
    func numberOfItemsInSection() -> Int {
        return Define.numberOfItemsInSection
    }

    func cellForItemAt() -> NowPlayingCollectionCellViewModel {
        let viewModel = NowPlayingCollectionCellViewModel()
        return viewModel
    }
}

extension LatestTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
