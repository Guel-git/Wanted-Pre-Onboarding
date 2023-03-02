//
//  ViewController.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/01.
//

import UIKit

import SnapKit

private let imageURLList = Literal.imageURLList
private var imageList: [UIImage] = []

final class ViewController: UIViewController {
    
    // MARK: - property
    
    private let collectionView = CollectionView()
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Load All Images", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        setRefreshButton()
        bindCellNumber()
    }
    
    // MARK: - func
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func render() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(630)
        }
        
        view.addSubview(refreshButton)
        refreshButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.height.equalTo(48)
        }
    }
    
    private func loadImage(cellNum: Int) {
        URLSession.shared.dataTask(with: NSURL(string: imageURLList[cellNum])! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.collectionView.imageList[cellNum] = UIImage(data: data!)
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.collectionView.imageList[cellNum] = Literal.defaultImage
            }
        }).resume()
    }
    
    private func setRefreshButton() {
        let action = UIAction { [weak self] _ in
            self?.loadAllImages()
        }
        refreshButton.addAction(action, for: .touchUpInside)
    }
    
    private func bindCellNumber() {
        collectionView.bindCellNumber = { [weak self] number in
            self?.loadImage(cellNum: number)
        }
    }
    
    private func loadAllImages() {
        for url in imageURLList {
            URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    return
                }
                imageList.append(UIImage(data: data!) ?? Literal.defaultImage)
            }).resume()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { () -> Void in
            self.collectionView.imageList = imageList
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            self.collectionView.imageList = Array(repeating: Literal.defaultImage, count: 5)
        }
    }
}
