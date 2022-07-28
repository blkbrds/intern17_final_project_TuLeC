//
//  LatestTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class LatestTableCellViewModel {
    func numberOfItemsInSection(in section: Int) -> Int {
        return Latest().numberOfItemsInSection
    }

    func cellForItemAt(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let viewModel = NowPlayingCollectionCellViewModel()
        return viewModel
    }
}

struct Latest {
    let numberOfItemsInSection: Int = 10
}
