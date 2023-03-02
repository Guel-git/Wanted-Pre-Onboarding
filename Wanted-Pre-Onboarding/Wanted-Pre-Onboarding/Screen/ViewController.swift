//
//  ViewController.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/01.
//

import UIKit

import SnapKit

private let imageURLList = ["https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg", "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg", "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg", "https://cdn.pixabay.com/photo/2013/08/20/15/47/poppies-174276_1280.jpg", "https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819_1280.jpg"]
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
        bindCellNumber()
        setRefreshButton()
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
                self.collectionView.imageList[cellNum] = UIImage(systemName: "photo")
            }
        }).resume()
    }
    
    private func bindCellNumber() {
        collectionView.bindCellNumber = { [weak self] number in
            self?.loadImage(cellNum: number)
        }
    }
    
    private func setRefreshButton() {
        let action = UIAction { [weak self] _ in
            self?.loadAllImages()
        }
        refreshButton.addAction(action, for: .touchUpInside)
    }
    
    private func loadAllImages() {
        for url in imageURLList {
            URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    imageList.append(UIImage(data: data!)!)
                })
            }).resume()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: { () -> Void in
                self.collectionView.imageList = imageList
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.collectionView.imageList = Array(repeating: UIImage(systemName: "photo"), count: 5)
        }
    }
}
