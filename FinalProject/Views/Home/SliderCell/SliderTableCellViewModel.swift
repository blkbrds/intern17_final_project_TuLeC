//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    enum GetDataResult {
        case success([Slider])
        case failure(APIError)
    }

    typealias Completion = (GetDataResult) -> Void

    private var slider: [Slider] = []

    func loadAPI(completion: @escaping Completion) {
        ApiManager.Video.callHomeApi(type: .popular) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let data = data, let items = data["results"] as? [JSObject] else { return }
                for slider in items {
                    this.slider.append(Slider(json: slider))
                }
                completion(.success(this.slider))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

    func numberOfItemsInSection() -> Int {
        if slider.count < Define.numberOfItemsInSection {
            return slider.count
        } else {
            return Define.numberOfItemsInSection
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> SliderCollectionCellViewModel {
        let item = slider[indexPath.row]
        let viewModel = SliderCollectionCellViewModel(slider: item)
        return viewModel
    }
}

extension SliderTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
