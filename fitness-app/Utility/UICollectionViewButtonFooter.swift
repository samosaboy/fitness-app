//
//  UICollectionReusableView.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import Foundation
import UIKit

class UICollectionViewButtonFooter: UICollectionReusableView {
    
    static var identifier: String = "ButtonFooter"
    
    var contentView: UIView!
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3)), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.backgroundColor = UIColor(named: "appButtonAlphaBlue")
        return button
    }()
    
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
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
