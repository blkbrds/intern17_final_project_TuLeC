//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit
import SVProgressHUD

final class HomeViewController: UIViewController {

    // MARK: - enum
    enum TypeCell: Int {
        case slider
        case nowPlaying
        case topRated
        case latest
        case upComing

        var deque: String {
            switch self {
            case .slider:
                return "SliderTableViewCell"
            case .nowPlaying:
                return "NowPlayingTableViewCell"
            case .topRated:
                return "TopRatedTableViewCell"
            case .latest:
                return "LatestTableViewCell"
            case .upComing:
                return "UpComingTableViewCell"
            }
        }
    }

    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Properties
    var viewModel: HomeViewModel?
    private var data: [TypeCell: [Slider]] = [:]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        callAllApi()
    }

    // MARK: - Private functions
    private func configUI() {
        configNavigationBar()
        configTableView()
    }

    private func callAllApi() {

        let dispatchGroup = DispatchGroup()
        SVProgressHUD.show()

        dispatchGroup.enter()
        ApiManager.Movie.getHomeApi(url: ApiManager.Movie.getSliderURL()) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.data[.slider] = data
            case .failure(let error):
                print(error.localizedDescription)
            }

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        ApiManager.Movie.getHomeApi(url: ApiManager.Movie.getNowPlayingURL()) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.data[.nowPlaying] = data
            case .failure(let error):
                print(error.localizedDescription)
            }

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        ApiManager.Movie.getHomeApi(url: ApiManager.Movie.getTopRated()) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.data[.topRated] = data
            case .failure(let error):
                print(error.localizedDescription)
            }

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        ApiManager.Movie.getHomeApi(url: ApiManager.Movie.getLatest()) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.data[.latest] = data
            case .failure(let error):
                print(error.localizedDescription)
            }

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        ApiManager.Movie.getHomeApi(url: ApiManager.Movie.getUpComing()) {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.data[.upComing] = data
            case .failure(let error):
                print(error.localizedDescription)
            }

            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    private func configNavigationBar() {
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: Define.nameImage))
        logoImageView.frame = Define.frameLogoImageView
        logoImageView.contentMode = Define.contentMode
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = Define.widthBarButtonItem
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]

        let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width * 3 / 4, height: 20))
        let searchButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: SizeWithScreen.shared.width * 3 / 4, height: 40))
        searchButton.addTarget(self, action: #selector(searchButtonTouchUpInside), for: .touchUpInside)
        searchBar.addSubview(searchButton)
        searchBar.placeholder = Define.searchBarPlaceholder
        let logoNavBar = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = logoNavBar
    }

    private func configTableView() {
        configNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }

    private func configNib() {
        let nib = UINib(nibName: Define.sliderTableCell, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Define.sliderTableCell)
        let nib2 = UINib(nibName: Define.nowPlayingTableCell, bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: Define.nowPlayingTableCell)
        let nib3 = UINib(nibName: Define.topRatedTableCell, bundle: .main)
        tableView.register(nib3, forCellReuseIdentifier: Define.topRatedTableCell)
        let nib4 = UINib(nibName: Define.latestTableCell, bundle: .main)
        tableView.register(nib4, forCellReuseIdentifier: Define.latestTableCell)
        let nib5 = UINib(nibName: Define.upComingTableViewCell, bundle: .main)
        tableView.register(nib5, forCellReuseIdentifier: Define.upComingTableViewCell)
    }

    // MARK: - objc functions
    @objc private func searchButtonTouchUpInside() {
        #warning("Handle later")
    }
}

// MARK: - Datasource,Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let type = TypeCell(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: type.deque, for: indexPath)
        switch type {
        case .slider:
            guard let cell = cell as? SliderTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(type: .slider, data: data[.slider] ?? []) as? SliderTableCellViewModel
        case .nowPlaying:
            guard let cell = cell as? NowPlayingTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(type: .nowPlaying, data: data[.nowPlaying] ?? []) as? NowPlayingTableCellViewModel
        case .topRated:
            guard let cell = cell as? TopRatedTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(type: .topRated, data: data[.topRated] ?? []) as? TopRatedTableCellViewModel
        case .latest:
            guard let cell = cell as? LatestTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(type: .latest, data: data[.latest] ?? []) as? LatestTableCellViewModel
        case .upComing:
            guard let cell = cell as? UpComingTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForItem(type: .upComing, data: data[.upComing] ?? []) as? UpComingTableCellViewModel
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }

        return SizeWithScreen.shared.height / CGFloat(viewModel.heightForRowAt(at: indexPath))
    }
}

// MARK: - Define
extension HomeViewController {
    struct Define {
        static let sliderTableCell: String = "SliderTableViewCell"
        static let nowPlayingTableCell: String = "NowPlayingTableViewCell"
        static let topRatedTableCell: String = "TopRatedTableViewCell"
        static let latestTableCell: String = "LatestTableViewCell"
        static let upComingTableViewCell: String = "UpComingTableViewCell"
        static let nameImage: String = "logo"

        static let widthBarButtonItem: CGFloat = -25
        static let contentMode: UIView.ContentMode = .scaleAspectFill
        static let searchBarPlaceholder: String = "Tìm kiếm"
        static let frameLogoImageView: CGRect = CGRect(x: 0, y: 0, width: 150, height: 25)
    }
}
