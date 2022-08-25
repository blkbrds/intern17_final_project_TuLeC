//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import Foundation
import RealmSwift

final class SearchViewModel {

    var history: [HistorySearch] = []
    var contentSearch: [Slider] = []

    func numberOfItemsInSection() -> Int {
        10
    }

    func numberOfRowContentInSection() -> Int {
        return contentSearch.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        guard let item = history[safe: indexPath.row]?.originalTitle else {
            return SearchCollectionCellViewModel(title: nil)
        }
        return SearchCollectionCellViewModel(title: item )
    }

    func viewNameForSuggest(at indexPath: IndexPath) -> String {
        return contentSearch[indexPath.row].originalTitle ?? ""
    }

    func viewModelForContentSearch(at indexPath: IndexPath) -> SearchContentViewModel {
        guard let item = contentSearch[safe: indexPath.row] else { return SearchContentViewModel(searchContents: nil) }
        return SearchContentViewModel(searchContents: item)
    }

    func fetchData(completion: (Bool) -> Void ) {
        do {
            let realm = try Realm()

            let results = realm.objects(HistorySearch.self)

            history = Array(results)

            completion(true)
        } catch {
            completion(false)
        }
    }

    func addHistory(title: String) {
        let realm = try? Realm()

        let history = HistorySearch()
        history.originalTitle = title

        try? realm?.write {
            realm?.add(history)
        }
    }

    func deleteAllHistory(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(HistorySearch.self)
            try realm.write {
                realm.delete(results)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }

    func getApiSearch(query: String, completion: @escaping (Bool) -> Void) {
        ApiManager.Search.getSearchURL(url: ApiManager.Search.getURL(query: query)) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.contentSearch = data
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
