//
//  SliderTableViewCell.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import UIKit

final class SliderTableViewCell: UITableViewCell {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!

    private var timer: Timer?
    private var currentIndex = 0
    var viewModel: SliderTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        startTimer()
        pageControl.numberOfPages = Define.numberOfPages
    }

    private func configCollectionView() {
        let nib = UINib(nibName: Define.sliderCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Define.sliderCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func updateCell() {
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    @objc private func moveToNextIndex() {
        if currentIndex < 9 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }

        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
}

extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Define.sliderCollectionCell, for: indexPath) as? SliderCollectionViewCell,
              let viewModel = viewModel else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellForItemAt()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeWithScreen.shared.width, height: self.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SliderTableViewCell {
    struct Define {
        static let sliderCollectionCell: String = "SliderCollectionViewCell"
        static let numberOfPages: Int = 10
    }
}
