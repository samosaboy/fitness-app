//
//  NewActivityCell.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import Foundation
import UIKit

class NewActivityCell: UICollectionViewCell {

    static var identifier: String = "NewActivityCell"

    weak var textLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                alpha = CGFloat(0.5)
            } else {
                alpha = CGFloat(1)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.numberOfLines = 0
        textLabel.textColor = .systemGray
        textLabel.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .semibold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        self.contentView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            textLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
        ])
        
        self.textLabel = textLabel
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.textLabel.textAlignment = .left
    }
}
