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
    private var currentCellIndex = 0
    var viewModel: SliderTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        startTimer()
        pageControl.numberOfPages = 10
    }

    private func updateCell() {
        let nib = UINib(nibName: Strings().sliderCollectionCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Strings().sliderCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    @objc private func moveToNextIndex() {
        if currentCellIndex < 9 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }

        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
    }
}

extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings().sliderCollectionCell, for: indexPath) as? SliderCollectionViewCell,
              let viewModel = viewModel else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellForItemAt(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeWithScreen().width, height: self.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
