//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    func numberOfItemsInSection() -> Int {
        return Define.numberOfItemsInSection
    }

    func cellForItemAt(at indexPath: IndexPath) -> SliderCollectionCellViewModel {
        let viewModel = SliderCollectionCellViewModel()
        return viewModel
    }
}

extension SliderTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
