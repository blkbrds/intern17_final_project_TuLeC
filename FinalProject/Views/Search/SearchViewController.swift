//
//  SearchViewController.swift
//  FinalProject
//
//  Created by tu.le2 on 22/08/2022.
//

import UIKit

final class SearchViewController: UIViewController {

    enum CellType {
        case contentSearchCell
        case suggestSearchCell
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: SearchViewModel?
    private var searchTimer: Timer?
    private var searchBar: UISearchBar = UISearchBar()
    private var searchCell: CellType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        configNavigationBar()
        configCollectionView()
    }

    private func configNavigationBar() {
        searchBar = Define.searchBar
        searchBar.placeholder = Define.placeHolder
        searchBar.delegate = self
        let searchNavBar = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = searchNavBar

        let backButton: UIButton = Define.backButton
        backButton.setTitle("Huỷ bỏ", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = Define.font
        backButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        let backNavBar = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = backNavBar
    }

    private func configCollectionView() {
        configNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = Define.contentInset
    }

    private func configNib() {
        let headerNib = UINib(nibName: Define.headerNib, bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Define.headerNib)
        let cellNib = UINib(nibName: Define.cellNib, bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Define.cellNib)
    }

    private func loadSuggestView() {
        if #available(iOS 10.0, *) {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
                DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                    DispatchQueue.main.async {
                        let tableView = UITableView()
                        tableView.frame = Define.framreSubView
                        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Define.suggestCell)
                        let nib = UINib(nibName: Define.contentSearchCell, bundle: .main)
                        tableView.register(nib, forCellReuseIdentifier: Define.contentSearchCell)
                        tableView.tag = Define.tagSubView
                        tableView.delegate = self
                        tableView.dataSource = self
                        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
                        self?.view.addSubview(tableView)
                    }
                }
            })
        } else {
            let tableView = UITableView()
            tableView.frame = Define.framreSubView
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: Define.suggestCell)
            tableView.tag = Define.tagSubView
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubview(tableView)
        }
    }

    private func removeSubview() {
        if let viewWithTag = self.view.viewWithTag(Define.tagSubView) {
            viewWithTag.removeFromSuperview()
        }
    }

    @objc private func pop() {
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
            header.frame = Define.headerFrame
            return header
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        searchBar.text = viewModel.history[indexPath.row]
        searchCell = .contentSearchCell
        loadSuggestView()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchCell = searchCell,
              let viewModel = viewModel else { return 0 }
        switch searchCell {
        case .contentSearchCell:
            return viewModel.numberOfRowContentInSection()
        case .suggestSearchCell:
            return viewModel.numberOfRowSuggestInSection()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchCell = searchCell,
              let viewModel = viewModel else { return UITableViewCell() }
        switch searchCell {
        case .contentSearchCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Define.contentSearchCell, for: indexPath) as? SearchContentTableViewCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForContentSearch()
            return cell
        case .suggestSearchCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: Define.suggestCell, for: indexPath)
            cell.textLabel?.text = viewModel.viewModelForSuggest(at: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchCell = .contentSearchCell
        tableView.reloadData()
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

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Define.sizeForHeader
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { return CGSize(width: 0, height: 0) }
        let cellWidth = (viewModel.history[indexPath.row].size(withAttributes: [.font: UIFont.systemFont(ofSize: 10.0)]).width ) + 50
        return CGSize(width: cellWidth, height: 30.0)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTimer?.invalidate()
        searchCell = .suggestSearchCell
        if !searchText.isEmpty && searchText != "" {
            loadSuggestView()
        } else {
            removeSubview()
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
