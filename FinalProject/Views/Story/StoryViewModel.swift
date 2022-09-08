//
//  StoryViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import Foundation
import CoreLocation

final class StoryViewModel {

    private(set) var map: [Map] = []

    func numberOfRowInSection() -> Int {
        return map.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> MapCollectionCellViewModel {
        guard let item = map[safe: indexPath.row] else {
            return MapCollectionCellViewModel(map: nil)
        }
        return MapCollectionCellViewModel(map: item)
    }

    func getApi(completion: @escaping Completion<[Map]>) {
        ApiManager.Map.getMapApi(url: ApiManager.Map.getURL(query: "coffee")) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.map = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getLocation(at indexPath: IndexPath) -> CLLocation {
        return CLLocation(latitude: map[indexPath.row].geocodes?.latitude ?? 0.0, longitude: map[indexPath.row].geocodes?.longitude ?? 0.0)
    }

    func getPins() -> [MyPin] {
        var pins: [MyPin] = []
        for item in map {
            pins.append(MyPin(title: item.name.content, coordinate: CLLocationCoordinate2D(latitude: item.geocodes?.latitude ?? 0.0, longitude: item.geocodes?.longitude ?? 0.0)))
        }
        return pins
    }
}
