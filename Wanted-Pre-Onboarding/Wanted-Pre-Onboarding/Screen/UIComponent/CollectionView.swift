//
//  CollectionView.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/01.
//

import UIKit

import SnapKit

final class CollectionView: UIView {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.width - 24 * 2
        static let cellHeight: CGFloat = 80
        static let collectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 24)
    }
    var imageList: [UIImage?] = Array(repeating: Literal.defaultImage, count: 5) {
        didSet {
            collectionView.reloadData()
        }
    }
    var bindCellNumber: ((Int) -> ())?
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 24
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = imageList[indexPath.item]
        
        cell.button.tag = indexPath.item
        cell.button.addTarget(self, action: #selector(didTappedLoadButton(sender: )), for: .touchUpInside)
        
        return cell
    }
}

extension CollectionView {
    @objc func didTappedLoadButton(sender : UIButton) {
        bindCellNumber?(sender.tag)
    }
}
