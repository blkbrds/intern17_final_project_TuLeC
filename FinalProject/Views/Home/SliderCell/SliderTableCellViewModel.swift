//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    // MARK: - Properties
    var sliders: [Slider]?

    // MARK: - public functions
    func numberOfItemsInSection() -> Int {
        guard let sliders = sliders else {
            return 0
        }

        if sliders.count < Define.numberOfItemsInSection {
            return sliders.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> SliderCollectionCellViewModel {
        guard let sliders = sliders else {
            return SliderCollectionCellViewModel(slider: nil)
        }

        let item = sliders[indexPath.row]
        let viewModel = SliderCollectionCellViewModel(slider: item)
        return viewModel
    }
}

// MARK: - Define
extension SliderTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
