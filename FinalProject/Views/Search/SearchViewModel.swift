//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import Foundation

final class SearchViewModel {

    #warning("dummy data")
    let history: [String] = ["Tinh hà sán lạng", "Trần tình lệnh", "Tranh thiên hạ", "Chỉ là quan hệ hôn nhân", "Đại thiên bồng"]
    let suggest: [String] = ["Tinh hà sán lạng", "Trần tình lệnh", "Tranh thiên hạ", "Chỉ là quan hệ hôn nhân", "Đại thiên bồng"]
    let contentSearch: [String] = ["Tinh hà sán lạng", "Trần tình lệnh", "Tranh thiên hạ", "Chỉ là quan hệ hôn nhân", "Đại thiên bồng"]

    func numberOfItemsInSection() -> Int {
        return history.count
    }

    func numberOfRowSuggestInSection() -> Int {
        return suggest.count
    }

    func numberOfRowContentInSection() -> Int {
        return contentSearch.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        return SearchCollectionCellViewModel(title: history[indexPath.row])
    }

    func viewModelForSuggest(at indexPath: IndexPath) -> String {
        return suggest[indexPath.row]
    }

    func viewModelForContentSearch() -> SearchContentViewModel {
        return SearchContentViewModel()
    }
}
