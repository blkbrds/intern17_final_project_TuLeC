//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import Foundation

final class DetailViewModel {

    var videoKey: Video?
    var details: [Slider] = []
    var id: Int
    var originalTitle: String
    var overview: String
    var genres: [Int]

    init(id: Int, originalTitle: String, overview: String, genres: [Int]) {
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.genres = genres
    }

    // MARK: - Public functions
    func viewModelForHeader() -> HeaderViewViewModel {
        return HeaderViewViewModel()
    }

    func viewModelForItem(at indexPath: IndexPath) -> DetailCollectionCellViewModel {
        guard let item = details[safe: indexPath.row] else {
            return DetailCollectionCellViewModel(sliderDetail: nil)
        }

        return DetailCollectionCellViewModel(sliderDetail: item)
    }

    func numberOfItems() -> Int {
        return details.count
    }

    func getDetailApi(movieId: Int, pageNumber: Int, completion: @escaping Completion<[Slider]>) {
        ApiManager.Detail.getDetailApi(url: ApiManager.Detail.getURL(movieID: movieId, page: pageNumber)) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                for item in data {
                    this.details.append(item)
                }
                completion(.success(data))
            case .failure(let error):
                print(error)
            }
        }
    }

    func getVideosApi(movieId: Int, completion: @escaping Completion<String>) {
        ApiManager.Video.getVideoApi(url: ApiManager.Video.getURL(movieID: movieId)) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.videoKey = data.first
                completion(.success(this.videoKey?.key ?? ""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getVideoKey() -> String {
        guard let videoKey = videoKey,
              let key = videoKey.key else {
            return ""
        }

        return key
    }

    func didSelectItemAt(indexPath: IndexPath) {
        guard let id = details[safe: indexPath.row]?.id,
              let originalTitle = details[safe: indexPath.row]?.originalTitle,
              let overview = details[safe: indexPath.row]?.overview,
              let genres = details[safe: indexPath.row]?.genres  else { return }
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.genres = genres
    }
}
