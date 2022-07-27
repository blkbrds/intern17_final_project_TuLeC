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

        var deque: String {
            switch self {
            case .slider:
                return "SliderTableViewCell"
            case .nowPlaying:
                return "NowPlayingTableViewCell"
            case .topRated:
                return "TopRatedTableViewCell"
            case .latest:
                return "LatestTableViewCell"
            case .upComing:
                return "UpComingTableViewCell"
            }
        }
    }

    func numberOfRowInSection(section: Int) -> Int {
        return TypeCell.allCases.count
    }

    func viewForItemAt(at indexPath: IndexPath) -> (Any, TypeCell) {
        guard let type = TypeCell(rawValue: indexPath.row) else {
            return (0, .slider)
        }

        switch type {
        case .slider:
            return (SliderTableCellViewModel(), .slider)
        case .nowPlaying:
            return (NowPlayingTableCellViewModel(), .nowPlaying)
        case .topRated:
            return (TopRatedTableCellViewModel(), .topRated)
        case .latest:
            return (LatestTableCellViewModel(), .latest)
        case .upComing:
            return (UpComingTableCellViewModel(), .upComing)
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> Double {
        guard let type = TypeCell(rawValue: indexPath.row) else {
            return 0
        }

        switch type {
        case .slider:
            return 3.5
        case .nowPlaying:
            return 5.32
        case .topRated:
            return 3.85
        case .latest:
            return 1 / 0.85
        case .upComing:
            return 4
        }
    }
}
