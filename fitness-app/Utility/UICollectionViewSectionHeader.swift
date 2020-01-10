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
    
    var contentView: UIView!
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    var sectionDescription: UILabel = {
        let label: UILabel = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(contentView)
                
        contentView.addSubview(label)
        contentView.addSubview(sectionDescription)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        sectionDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: sectionDescription.topAnchor),
            
            sectionDescription.topAnchor.constraint(equalTo: label.bottomAnchor),
            sectionDescription.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            sectionDescription.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            sectionDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
