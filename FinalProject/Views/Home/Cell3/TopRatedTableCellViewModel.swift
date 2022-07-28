//
//  TopRatedTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class TopRatedTableCellViewModel {
    func numberOfItemsInSection(in section: Int) -> Int {
        return TopRated().numberOfItemsInSection
    }

    func cellForItemAt(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let viewModel = NowPlayingCollectionCellViewModel()
        return viewModel
    }
}

struct TopRated {
    let numberOfItemsInSection: Int = 10
}
