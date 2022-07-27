//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    func numberOfItemsInSection(in section: Int) -> Int {
        return 10
    }

    func viewForItemAt(at indexPath: IndexPath) -> SliderCollectionCellViewModel {
        let cell = SliderCollectionCellViewModel()
        return cell
    }
}
