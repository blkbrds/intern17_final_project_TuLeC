//
//  SearchViewController.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import UIKit
import RealmSwift

final class SearchViewController: UIViewController {

    enum CellType {
        case contentSearchCell
        case suggestSearchCell
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: SearchViewModel?
    private var searchTimer: Timer?
    private var searchBar: UISearchBar = UISearchBar()
    private var tableView = UITableView()
    private var searchCell: CellType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        configNavigationBar()
        configCollectionView()
        configTableView()
        tabBarController?.tabBar.isHidden = true
    }

    private func configNavigationBar() {
        searchBar = Define.searchBar
        searchBar.placeholder = Define.placeHolder
        searchBar.delegate = self
        let searchNavBar = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = searchNavBar

        let backButton: UIButton = Define.backButton
        backButton.setTitle("Huỷ bỏ", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = Define.font
        backButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        let backNavBar = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = backNavBar
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationItem.scrollEdgeAppearance = navigationBarAppearance
        }
    }

    private func configTableView() {
        tableView.frame = Define.framreSubView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Define.suggestCell)
        let nib = UINib(nibName: Define.contentSearchCell, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Define.contentSearchCell)
        tableView.tag = Define.tagSubView
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configCollectionView() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.fetchData { done in
            if done {
                configNib()
                collectionView.contentInset = Define.contentInset
                collectionView.delegate = self
                collectionView.dataSource = self
            } else {
                print("lỗi")
            }
        }
    }

    private func configNib() {
        let headerNib = UINib(nibName: Define.headerNib, bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Define.headerNib)
        let cellNib = UINib(nibName: Define.cellNib, bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellNib)
    }

    private func loadSuggestView(query: String) {
        if #available(iOS 10.0, *) {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                    guard let this = self else { return }
                    this.loadContentSearch(query: query)
                }
            })
        } else {
            loadContentSearch(query: query)
        }
    }

    private func loadContentSearch(query: String) {
        guard let viewModel = viewModel else {
            return
        }

        DispatchQueue.main.async {
            viewModel.getApiSearch(query: query) { _ in
                if self.view.viewWithTag(Define.tagSubView) != nil {
                    self.tableView.reloadData()
                } else {
                    self.view.addSubview(self.tableView)
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func removeTableView() {
        if let viewWithTag = view.viewWithTag(Define.tagSubView) {
            viewWithTag.removeFromSuperview()
        }
    }

    @objc private func pop() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
        searchBar.text = ""
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.cellNib, for: indexPath)
                as? SearchCollectionViewCell,
              let viewModel = viewModel else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Define.headerNib, for: indexPath) as? SearchHeaderView else {
                return UICollectionReusableView()
            }
            header.delegate = self
            header.frame = Define.headerFrame
            return header
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        searchBar.text = viewModel.history[indexPath.row].originalTitle
        searchCell = .contentSearchCell
        loadContentSearch(query: viewModel.history[indexPath.row].originalTitle)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Define.sizeForHeader
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { return CGSize(width: 0, height: 0) }
        guard let originalTitle = viewModel.history[safe: indexPath.row]?.originalTitle else { return CGSize(width: 0, height: 0) }
        let cellWidth = (originalTitle.size(withAttributes: [.font: UIFont.systemFont(ofSize: 10.0)]).width ) + 50
        return CGSize(width: cellWidth, height: 30.0)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowContentInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchCell = searchCell,
              let viewModel = viewModel else { return UITableViewCell() }
        switch searchCell {
        case .contentSearchCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.contentSearchCell, for: indexPath) as? SearchContentTableViewCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForContentSearch(at: indexPath)
            return cell
        case .suggestSearchCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: Define.suggestCell, for: indexPath)
            cell.textLabel?.text = viewModel.viewNameForSuggest(at: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        searchCell = .contentSearchCell
        searchBar.text = viewModel.contentSearch[indexPath.row].originalTitle
        loadContentSearch(query: searchBar.text ?? "")
        viewModel.addHistory(title: viewModel.contentSearch[indexPath.row].originalTitle ?? "")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let searchCell = searchCell else { return 0 }
        switch searchCell {
        case .contentSearchCell:
            return Define.heightContentSearchCell
        case .suggestSearchCell:
            return Define.heightSuggestSearchCell
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = viewModel else { return }
        self.searchTimer?.invalidate()
        searchCell = .suggestSearchCell
        if !searchText.isEmpty && searchText != "" {
            loadSuggestView(query: searchText)
        } else {
            removeTableView()
        }
        viewModel.fetchData { done in
            if done {
                collectionView.reloadData()
            } else {
                print("lỗi")
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let viewModel = viewModel,
              let searchString = searchBar.text else { return }
        searchCell = .contentSearchCell
        viewModel.addHistory(title: searchString)
        tableView.reloadData()
    }
}

extension SearchViewController: SearchHeaderViewDelegate {
    func view(view: SearchHeaderView) {
        guard let viewModel = viewModel else { return }
        viewModel.deleteAllHistory { done in
            if done {
                viewModel.fetchData { done in
                    if done {
                        collectionView.reloadData()
                    } else {
                        print("lỗi")
                    }
                }
            } else {
                print("lỗi")
            }
        }
    }
}

extension SearchViewController {
    struct Define {
        static let placeHolder: String = "Tìm kiếm"
        static let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        static let font = UIFont(name: "Helvetica", size: 15)
        static let contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        static let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width * 3 / 4, height: 20))
        static let headerNib: String = "SearchHeaderView"
        static let cellNib: String = "SearchCollectionViewCell"
        static let suggestCell: String = "SuggestTableViewCell"
        static let contentSearchCell: String = "SearchContentTableViewCell"
        static let headerFrame = CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width - 20, height: 50)
        static let tagSubView: Int = 100
        static let framreSubView = CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width, height: SizeWithScreen.shared.height)
        static let heightContentSearchCell: CGFloat = 100
        static let heightSuggestSearchCell: CGFloat = 50
        static let sizeForHeader = CGSize(width: SizeWithScreen.shared.width, height: 50)
    }
}
