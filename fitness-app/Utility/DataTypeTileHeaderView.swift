//
//  DataTypeTileHeaderView.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-29.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

class DataTypeTileHeaderView {
    var view = UIView()
    fileprivate var cell = UITableViewCell()
    
    init(image: UIImage, label: UILabel, detailedTextLabel: String? = nil) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        cell = UITableViewCell(style: .value1, reuseIdentifier: DataTypeTileHeaderView.reuseIdentifier)
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.image = image
        cell.imageView?.tintColor = .systemRed
        cell.textLabel?.text = label.text
        cell.textLabel?.textColor = label.tintColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .medium)
        
        if detailedTextLabel != nil {
            cell.detailTextLabel?.text = detailedTextLabel
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .regular)
        }
        cell.accessoryType = .disclosureIndicator
        view.addSubview(cell)
        
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            cell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            cell.topAnchor.constraint(equalTo: view.topAnchor),
            cell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension DataTypeTileHeaderView: Reusable {}
