//
//  SliderTableCellViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

final class SliderTableCellViewModel {

    private var sliders: [Slider]?

    func loadAPI(completion: @escaping Completion<[Slider]>) {
        let url = ApiManager.Movie.getSliderURL()
        
        ApiManager.Movie.getHomeApi(url: url) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let data):
                this.sliders = data
                let userdefault = UserDefaults.standard
                guard let movieId = data.first?.id else {
                    return
                }
                userdefault.set(movieId, forKey: Session.shared.movieId)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }

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

extension SliderTableCellViewModel {
    struct Define {
        static let numberOfItemsInSection: Int = 10
    }
}
