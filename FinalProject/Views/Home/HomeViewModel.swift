//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation

final class HomeViewModel {
    // MARK: - enum
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

    // MARK: - Public functions
    func numberOfRowInSection() -> Int {
        return TypeCell.allCases.count
    }

    func viewModelForItem(type: TypeCell, data: [Slider]) -> (Any) {
        switch type {
        case .slider:
            return (SliderTableCellViewModel(sliders: data))
        case .nowPlaying:
            return (NowPlayingTableCellViewModel(nowPlayings: data))
        case .topRated:
            return (TopRatedTableCellViewModel(topRated: data))
        case .latest:
            return (LatestTableCellViewModel(latest: data))
        case .upComing:
            return (UpComingTableCellViewModel(upComings: data))
        }
    }

    func getHomeApi(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getURL(type: .popular, typePath: ApiManager.Path.popular, movieId: nil)
        ApiManager.Movie.getHomeApi(url: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> Double {
        guard let type = TypeCell(rawValue: indexPath.row) else {
            return 0
        }

        return type.ratioHeightForRow
    }

    func viewModelForDetail(detail: Slider) -> DetailViewModel {
        return DetailViewModel(detail: detail)
    }
}
