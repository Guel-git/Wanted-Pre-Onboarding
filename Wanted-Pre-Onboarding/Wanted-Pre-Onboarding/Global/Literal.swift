//
//  Literal.swift
//  Wanted-Pre-Onboarding
//
//  Created by 김유나 on 2023/03/02.
//

import UIKit

enum Literal {
    
    // MARK: - Image

    static var defaultImage: UIImage { .load(systemName: "photo") }
    
    // MARK: - ImageURLList
    
    static let imageURLList = ["https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg", "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg", "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg", "https://cdn.pixabay.com/photo/2013/08/20/15/47/poppies-174276_1280.jpg", "https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819_1280.jpg"]
    
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}
