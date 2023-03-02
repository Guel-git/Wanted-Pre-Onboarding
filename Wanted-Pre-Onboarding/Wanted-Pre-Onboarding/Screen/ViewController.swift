//
//  ViewController.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/01.
//

import UIKit

import SnapKit

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
        loadImage()
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
    
    private func loadImage() {
        URLSession.shared.dataTask(with: NSURL(string: "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg")! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.collectionView.imageList[0] = UIImage(data: data!)
            })
        }).resume()
    }
    
    private func bindCellNumber() {
        collectionView.bindCellNumber = { [weak self] number in
            print(number)
        }
    }
}
