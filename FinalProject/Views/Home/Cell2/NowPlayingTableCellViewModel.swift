//
//  NowPlayingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class NowPlayingTableCellViewModel {

    func numberOfItemsInSection(in section: Int) -> Int {
        return NowPlaying().numberOfItemsInSection
    }

    func cellForItemAt(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let viewModel = NowPlayingCollectionCellViewModel()
        return viewModel
    }
}

struct NowPlaying {
    let numberOfItemsInSection: Int = 10
}
