//
//  StoryViewController.swift
//  FinalProject
//
//  Created by tu.le2 on 22/07/2022.
//

import UIKit
import MapKit
import SVProgressHUD
import CoreLocation

final class StoryViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var mapView: MKMapView!

    var viewModel: StoryViewModel?
    private var isError: Bool = false
    private var errorString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        configUI()
    }

    private func callApi() {
        guard let viewModel = viewModel else {
            return
        }
        SVProgressHUD.show()
        getApi {
            SVProgressHUD.dismiss {
                if self.isError {
                    self.showErrorDialog(message: self.errorString) {
                        self.dismiss(animated: true)
                    }
                } else {
                    self.mapView.addAnnotations(viewModel.getPins())
                    self.collectionView.reloadData()
                }
            }
        }
    }

    private func getApi(completion: @escaping (() -> Void)) {
        guard let viewModel = viewModel else {
            completion()
            return
        }
        viewModel.getApi { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                completion()
            case .failure(let error):
                this.isError = true
                this.errorString = error.localizedDescription
                completion()
            }
        }
    }

    private func configUI() {
        LocationManager.shared().request()
        LocationManager.shared().getCurrentLocation { (location) in
            self.center(location: location)
        }
        let nib = UINib(nibName: Define.nibString, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Define.nibString)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func center(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        let span = Define.span
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
}

extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.nibString, for: indexPath) as? MapCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        center(location: viewModel.getLocation(at: indexPath))
    }
}

extension StoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Define.size
    }
}

extension StoryViewController {
    struct Define {
        static let nibString: String = "MapCollectionViewCell"
        static let size: CGSize = CGSize(width: SizeWithScreen.shared.width / 3, height: 300)
        static let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
}
