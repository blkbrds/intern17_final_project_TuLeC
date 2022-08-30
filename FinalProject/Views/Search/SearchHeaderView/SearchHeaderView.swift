//
//  SearchHeaderView.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import UIKit

protocol SearchHeaderViewDelegate: AnyObject {
    func view(view: SearchHeaderView)
}

final class SearchHeaderView: UICollectionReusableView {

    enum ActionType {
        case delete
    }

    weak var delegate: SearchHeaderViewDelegate?

    @IBAction private func deleteButtonTouchUpInside(_ sender: UIButton) {
        delegate?.view(view: self)
    }

}
