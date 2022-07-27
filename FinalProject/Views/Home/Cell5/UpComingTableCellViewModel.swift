//
//  UpComingTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 26/07/2022.
//

import Foundation

final class UpComingTableCellViewModel {
    func numberOfItemsInSection(in section: Int) -> Int {
        return 10
    }

    func viewForItemAt(at indexPath: IndexPath) -> NowPlayingCollectionCellViewModel {
        let cell = NowPlayingCollectionCellViewModel()
        return cell
    }
}
