//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    func numberOfItemsInSection(in section: Int) -> Int {
        return SliderTableCell().numberOfItemsInSection
    }

    func cellForItemAt(at indexPath: IndexPath) -> SliderCollectionCellViewModel {
        let viewModel = SliderCollectionCellViewModel()
        return viewModel
    }
}

struct SliderTableCell {
    let numberOfItemsInSection: Int = 10
}
