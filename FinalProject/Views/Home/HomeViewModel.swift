//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class HomeViewModel {
    enum TypeCell: Int, CaseIterable {
        case slider
        case nowPlaying
        case topRated
        case latest
        case upComing

        var ratioHeightForRow: Double {
            switch self {
            case .slider:
                return 3.5
            case .nowPlaying:
                return 4.5
            case .topRated:
                return 3.5
            case .latest:
                return 1 / 0.85
            case .upComing:
                return 4.4
            }
        }
    }

    func numberOfRowInSection() -> Int {
        return TypeCell.allCases.count
    }

    func viewModelForItem(type: TypeCell) -> (Any) {
        switch type {
        case .slider:
            return (SliderTableCellViewModel())
        case .nowPlaying:
            return (NowPlayingTableCellViewModel())
        case .topRated:
            return (TopRatedTableCellViewModel())
        case .latest:
            return (LatestTableCellViewModel())
        case .upComing:
            return (UpComingTableCellViewModel())
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> Double {
        guard let type = TypeCell(rawValue: indexPath.row) else {
            return 0
        }

        return type.ratioHeightForRow
    }
}
