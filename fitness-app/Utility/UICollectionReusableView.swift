//
//  UICollectionReusableView.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import Foundation
import UIKit

class UICollectionViewSectionHeader: UICollectionReusableView {
    
    static var identifier: String = "SectionHeader"
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    var sectionDescription: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(sectionDescription)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        sectionDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            sectionDescription.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            sectionDescription.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            sectionDescription.trailingAnchor.constraint(equalTo: label.trailingAnchor),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
