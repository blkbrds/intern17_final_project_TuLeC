//
//  GenresCollectionCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 10/08/2022.
//

import Foundation

final class GenresCollectionCellViewModel {

    // MARK: - Properties
    var genre: Genres?
    var isSelected: Bool

    // MARK: - Initialize
    init(genre: Genres?, isSelected: Bool = false) {
        self.genre = genre
        self.isSelected = isSelected
    }
}
