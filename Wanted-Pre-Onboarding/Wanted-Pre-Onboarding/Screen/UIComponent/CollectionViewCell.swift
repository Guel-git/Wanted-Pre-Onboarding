//
//  CollectionViewCell.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/01.
//

import UIKit

import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - property
    
    let imageView = UIImageView()
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = .systemGray5
        progressView.progressTintColor = .systemBlue
        progressView.progress = 0.3
        progressView.layer.cornerRadius = 2
        return progressView
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Load", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(70)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalTo(button.snp.leading)
            $0.height.equalTo(5)
            $0.centerY.equalToSuperview()
        }
    }
}
