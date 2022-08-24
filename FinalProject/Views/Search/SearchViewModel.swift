//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import Foundation
import RealmSwift

final class SearchViewModel {

    #warning("dummy data")
    var history: [HistorySearch] = []
    let suggest: [String] = ["Tinh hà sán lạng", "Trần tình lệnh", "Tranh thiên hạ", "Chỉ là quan hệ hôn nhân", "Đại thiên bồng"]
    let contentSearch: [String] = ["Tinh hà sán lạng", "Trần tình lệnh", "Tranh thiên hạ", "Chỉ là quan hệ hôn nhân", "Đại thiên bồng"]

    func numberOfItemsInSection() -> Int {
        if history.count < 10 {
            return history.count
        } else {
            return 10
        }
    }

    func numberOfRowSuggestInSection() -> Int {
        return suggest.count
    }

    func numberOfRowContentInSection() -> Int {
        return contentSearch.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        return SearchCollectionCellViewModel(title: history[indexPath.row].originalTitle )
    }

    func viewModelForSuggest(at indexPath: IndexPath) -> String {
        return suggest[indexPath.row]
    }

    func viewModelForContentSearch() -> SearchContentViewModel {
        return SearchContentViewModel()
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

}
