//
//  ExploreHeaderView.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import UIKit

protocol ExploreHeaderViewDelegate: AnyObject {
    func view(view: ExploreHeaderView, needPerformAtion action: ExploreHeaderView.Action)
}

final class ExploreHeaderView: UICollectionReusableView {

    // MARK: - Enums
    enum Action {
        case passDataFromHeader(genresKey: [SelectKey])
    }

    // MARK: - IBOutlets
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    weak var delegate: ExploreHeaderViewDelegate?
    private var genresKey: [SelectKey] = []
    var viewModel: ExploreHeaderViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    // MARK: - Private functions
    private func updateCell() {
        collectionView.reloadData()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: Define.genresCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Define.genresCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Delegate, DataSource
extension ExploreHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.genresCollectionCell, for: indexPath) as? GenresCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}

// MARK: - CollectionView Delegate, DataSource
extension ExploreHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else {
            return CGSize(width: 0, height: 0)
        }
        let cellWidth = viewModel.sizeForItem(at: indexPath).size(withAttributes: [.font: UIFont.systemFont(ofSize: 10.0)]).width + 50.0
        return CGSize(width: cellWidth, height: 30.0)
    }
}

extension ExploreHeaderView: GenresCollectionViewCellDelegate {
    func cell(cell: GenresCollectionViewCell, needPerformAtion action: GenresCollectionViewCell.Action) {
        guard let viewModel = viewModel else {
            return
        }
        switch action {
        case .genresButtonIsSelected(let data):
            let genresArray = viewModel.removeData(data: data, genresKey: genresKey).genresArray
            genresKey = viewModel.removeData(data: data, genresKey: genresKey).genresKey

            guard let delegate = delegate else {
                return
            }
            delegate.view(view: self, needPerformAtion: .passDataFromHeader(genresKey: genresArray))
        }
    }
}

// MARK: - Define
extension ExploreHeaderView {
    struct Define {
        static let genresCollectionCell: String = "GenresCollectionViewCell"
    }
}
