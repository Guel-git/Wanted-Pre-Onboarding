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
    
    private let imageView = UIImageView(image: UIImage(systemName: "photo"))
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = .gray
        progressView.progressTintColor = .blue
        return progressView
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Load", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
            $0.width.equalTo(30)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing)
            $0.trailing.equalTo(button.snp.leading)
            $0.height.equalTo(1)
        }
    }
}
