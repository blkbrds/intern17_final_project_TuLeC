//
//  ExploreViewController.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import UIKit
import SVProgressHUD

final class ExploreViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: ExploreViewModel?
    private var loadingView: LoadingReusableView?
    private var pageNumber: Int = 1
    private var isLoading: Bool = false

    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        callApi(genresKey: [], pageNumber: pageNumber)
    }

    // MARK: - Private functions
    private func callApi(genresKey: [Int], pageNumber: Int, isCallKey: Bool = true) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getAPIContenMovie(genresKey: genresKey, pageNumber: pageNumber) {
            dispatchGroup.leave()
        }

        guard isCallKey else {
            dispatchGroup.notify(queue: .main) {
                self.collectionView.reloadData()
            }
            return
        }
        dispatchGroup.enter()
        getAPIGenres {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }

    private func getAPIContenMovie(genresKey: [Int], pageNumber: Int, completion: @escaping (() -> Void)) {
        guard let viewModel = viewModel else { return }

        viewModel.getExploreApi(genresKey: genresKey, pageNumber: pageNumber, completion: { _ in completion() })
    }

    private func getAPIGenres(completion: @escaping(() -> Void)) {
        guard let viewModel = viewModel else { return }
        viewModel.getGenresApi(completion: { _ in completion() })
    }

    private func configNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = Define.titleLabel
        titleLabel.font = Define.systemFont
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem

        let searchButton = Define.searchButton
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: Define.systemName)
            searchButton.setImage(image, for: .normal)
            searchButton.tintColor = Define.tintColor
        } else {
        }

        let rightItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightItem
    }

    private func configTableView() {
        configNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = Define.contentInset
    }

    private func configNib() {
        let headerNib = UINib(nibName: Define.header, bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Define.header)
        let footterNib = UINib(nibName: Define.loadingReusableViewCell, bundle: .main)
        collectionView.register(footterNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Define.loadingReusableViewCell)
        let contentMovieNib = UINib(nibName: Define.contentMovieNib, bundle: .main)
        collectionView.register(contentMovieNib, forCellWithReuseIdentifier: Define.contentMovieNib)
    }

    private func loadMoreData() {
        if isLoading {
            pageNumber += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                guard let viewModel = self.viewModel else { return }
                self.isLoading = false
                self.callApi(genresKey: viewModel.genresKeys, pageNumber: self.pageNumber, isCallKey: false)
            }
        }
    }
}

// MARK: - Delegate, DataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.numberOfItemsInSection(pageNumber: pageNumber)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.contentMovieNib, for: indexPath) as? ContentMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Define.header, for: indexPath)
                    as? ExploreHeaderView,
                  let viewModel = viewModel else {

                return UICollectionReusableView()

            }
            header.delegate = self
            header.frame = CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width, height: Define.genresCellHeight)
            header.viewModel = viewModel.viewModelForHeader(data: viewModel.genres)
            return header
        default:
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Define.loadingReusableViewCell, for: indexPath) as? LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView ?? UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        if indexPath.row == viewModel.numberOfItemsInSection(pageNumber: pageNumber) - Define.itemStartReload {
            isLoading = !isLoading
            loadMoreData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            guard let loadingView = loadingView else {
                return
            }
            loadingView.isShowIndicator = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            guard let loadingView = loadingView else {
                return
            }
            loadingView.isShowIndicator = false
        }
    }
}

// MARK: - DelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SizeWithScreen.shared.width, height: Define.genresCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Define.sizeForItemAt
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: Define.heightFootter)
        }
    }
}

extension ExploreViewController: ExploreHeaderViewDelegate {
    func view(view: ExploreHeaderView, needPerformAtion action: ExploreHeaderView.Action) {
        guard let viewModel = viewModel else {
            return
        }
        switch action {
        case .passKeyFromHeader(genresKey: let key):
            viewModel.contentMovies.removeAll()
            pageNumber = 1
            if let index = viewModel.genresKeys.firstIndex(of: key) {
                viewModel.genresKeys.remove(at: index)
            } else {
                viewModel.genresKeys.append(key)
            }
            callApi(genresKey: viewModel.genresKeys, pageNumber: pageNumber, isCallKey: false)
        }
    }
}

// MARK: - Define
extension ExploreViewController {
    struct Define {
        static let header: String = "ExploreHeaderView"
        static let loadingReusableViewCell: String = "LoadingReusableView"
        static let contentMovieNib = "ContentMovieCollectionViewCell"
        static let titleLabel: String = "Khám phá"
        static let systemName: String = "magnifyingglass"
        static let genresCellHeight: CGFloat = 210
        static let sizeForItemAt = CGSize(width: ((SizeWithScreen.shared.width - 30) / 2) * 0.65, height: (SizeWithScreen.shared.height) / 4.2)
        static let systemFont = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        static let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        static let tintColor: UIColor = .gray
        static let contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        static let heightFootter: CGFloat = 40
        static let itemStartReload: Int = 5
    }
}
