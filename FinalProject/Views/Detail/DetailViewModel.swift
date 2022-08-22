//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 17/08/2022.
//

import Foundation

final class DetailViewModel {

    var videoKey: Video?
    var detail: [Slider] = []

    // MARK: - Public functions
    func viewModelForHeader() -> HeaderViewViewModel {
        return HeaderViewViewModel()
    }

    func viewModelForItem(at indexPath: IndexPath) -> DetailCollectionCellViewModel {
        guard let item = detail[safe: indexPath.row] else {
            return DetailCollectionCellViewModel(detail: nil)
        }

        return DetailCollectionCellViewModel(detail: item)
    }

    func numberOfItems() -> Int {
        return detail.count
    }

    func getDetailApi(movieId: Int, pageNumber: Int, completion: @escaping Completion<[Slider]>) {
        ApiManager.Detail.getDetailApi(url: ApiManager.Detail.getURL(movieID: movieId, page: pageNumber)) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                for item in data {
                    this.detail.append(item)
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
                completion(.success(this.videoKey?.key ?? "766507"))
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
}
