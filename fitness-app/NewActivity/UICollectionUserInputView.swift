
//
//  UICollectionViewUserInputView.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-06.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import Foundation
import UIKit

class UICollectionUserInputView: UICollectionViewCell {
    
    static var identifier: String = "UserInputCell"

    weak var textLabel: UILabel!
    weak var background: UIView!
    
    lazy var textInputView: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        let background = UIView(frame: .zero)
        
        textLabel.numberOfLines = 0
        textLabel.textColor = .systemGray
        textLabel.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .regular)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(makeTextInputViewActive))
        background.addGestureRecognizer(tap)
        
        background.layer.backgroundColor = UIColor(named: "defaultCell")?.cgColor
        background.layer.cornerRadius = 10
        background.layer.cornerRadius = 10
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.cornerRadius = 10
        background.layer.shadowOpacity = 0.1
        background.layer.shadowOffset = .zero
        background.layer.shadowRadius = 10
        background.layer.shouldRasterize = true
        background.layer.rasterizationScale = UIScreen.main.scale
        background.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(background)
        background.addSubview(textInputView)
        background.addSubview(textLabel)

        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            background.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 15),
            textLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 15),
            textLabel.widthAnchor.constraint(equalTo: background.widthAnchor, constant: -25),
            
            textInputView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            textInputView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textInputView.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            textInputView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -15),

        ])
        
        self.textLabel = textLabel
        self.reset()
    }
    
    @objc func makeTextInputViewActive() {
        self.textInputView.becomeFirstResponder()
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
