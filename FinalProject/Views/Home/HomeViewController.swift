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
        let nib = UINib(nibName: "SliderTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "SliderTableViewCell")
        let nib2 = UINib(nibName: "NowPlayingTableViewCell", bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: "NowPlayingTableViewCell")
        let nib3 = UINib(nibName: "TopRatedTableViewCell", bundle: .main)
        tableView.register(nib3, forCellReuseIdentifier: "TopRatedTableViewCell")
        let nib4 = UINib(nibName: "LatestTableViewCell", bundle: .main)
        tableView.register(nib4, forCellReuseIdentifier: "LatestTableViewCell")
        let nib5 = UINib(nibName: "UpComingTableViewCell", bundle: .main)
        tableView.register(nib5, forCellReuseIdentifier: "UpComingTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.viewForItemAt(at: indexPath).1.deque, for: indexPath)
        switch viewModel.viewForItemAt(at: indexPath).1 {
        case .slider:
            guard let cell = cell as? SliderTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.viewForItemAt(at: indexPath).0 as? SliderTableCellViewModel
        case .nowPlaying:
            guard let cell = cell as? NowPlayingTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.viewForItemAt(at: indexPath).0 as? NowPlayingTableCellViewModel
        case .topRated:
            guard let cell = cell as? TopRatedTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel.viewForItemAt(at: indexPath).0 as? TopRatedTableCellViewModel
        case .latest:
            guard let cell = cell as? LatestTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewForItemAt(at: indexPath).0 as? LatestTableCellViewModel
        case .upComing:
            guard let cell = cell as? UpComingTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewForItemAt(at: indexPath).0 as? UpComingTableCellViewModel
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }

        return UIScreen.main.bounds.height / CGFloat(viewModel.heightForRowAt(at: indexPath))
    }
}
