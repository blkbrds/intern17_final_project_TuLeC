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

class SearchHeaderView: UICollectionReusableView {

    weak var delegate: SearchHeaderViewDelegate?

    @IBAction func deleteButtonTouchUpInside(_ sender: UIButton) {
        guard let delegate = delegate else {
            return
        }
        delegate.view(view: self)
    }

}
