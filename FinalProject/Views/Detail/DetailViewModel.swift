//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import Foundation

final class DetailViewModel {

    // MARK: - Public functions
    func viewModelForHeader() -> HeaderViewViewModel {
        return HeaderViewViewModel()
    }

    func viewModelForItem() -> DetailCollectionCellViewModel {
        return DetailCollectionCellViewModel()
    }

    func numberOfItems() -> Int {
        return 15
    }
}
