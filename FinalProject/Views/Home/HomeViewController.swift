//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        configNavigationBar()
        configTableView()
    }

    private func configNavigationBar() {
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.frame = CGRect(x: 0, y: 0, width: 150, height: 25)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]

        let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 3 / 4, height: 20))
        let searchButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 3 / 4, height: 40))
        searchButton.addTarget(self, action: #selector(searchButtonTouchUpInside), for: .touchUpInside)
        searchBar.addSubview(searchButton)
        searchBar.placeholder = "Tìm kiếm"
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
        let nib = UINib(nibName: Strings().sliderTableCell, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Strings().sliderTableCell)
        let nib2 = UINib(nibName: Strings().nowPlayingTableCell, bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: Strings().nowPlayingTableCell)
        let nib3 = UINib(nibName: Strings().topRatedTableCell, bundle: .main)
        tableView.register(nib3, forCellReuseIdentifier: Strings().topRatedTableCell)
        let nib4 = UINib(nibName: Strings().latestTableCell, bundle: .main)
        tableView.register(nib4, forCellReuseIdentifier: Strings().latestTableCell)
        let nib5 = UINib(nibName: Strings().upComingTableViewCell, bundle: .main)
        tableView.register(nib5, forCellReuseIdentifier: Strings().upComingTableViewCell)
    }

    @objc private func searchButtonTouchUpInside() {
        print("abc")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellForRowAt(at: indexPath).typeCell.deque, for: indexPath)
        switch viewModel.cellForRowAt(at: indexPath).typeCell {
        case .slider:
            guard let cell = cell as? SliderTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.cellForRowAt(at: indexPath).viewModel as? SliderTableCellViewModel
        case .nowPlaying:
            guard let cell = cell as? NowPlayingTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.cellForRowAt(at: indexPath).viewModel as? NowPlayingTableCellViewModel
        case .topRated:
            guard let cell = cell as? TopRatedTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.cellForRowAt(at: indexPath).viewModel as? TopRatedTableCellViewModel
        case .latest:
            guard let cell = cell as? LatestTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.cellForRowAt(at: indexPath).viewModel as? LatestTableCellViewModel
        case .upComing:
            guard let cell = cell as? UpComingTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.cellForRowAt(at: indexPath).viewModel as? UpComingTableCellViewModel
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }

        return HomeView(height: CGFloat(viewModel.heightForRowAt(at: indexPath))).heightForRowAt
    }
}

struct HomeView {
    var heightForRowAt: CGFloat

    init(height: CGFloat) {
        heightForRowAt = SizeWithScreen().height / height
    }
}

class SizeWithScreen {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let size = UIScreen.main.bounds.size
}
