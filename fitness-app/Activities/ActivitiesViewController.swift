//
//  ActivitiesViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-27.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController, UIScrollViewDelegate {
    
    let currentActivityVC = CurrentActivityViewController()
    let todaysActivityVC = TodaysActivitiesViewController()
    
    let scrollView = UIScrollView()
    //    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor(named: "defaultBackground")
        setupScrollView()
        createAddButton()
        setupViews()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    func setupViews(){
        createCurrentWorkout()
    }
    
    fileprivate func createCurrentWorkout() {
        addChild(currentActivityVC)
        currentActivityVC.view.translatesAutoresizingMaskIntoConstraints = false
        let currentActivityVCView: UIView = currentActivityVC.view
        scrollView.addSubview(currentActivityVCView)
        
        NSLayoutConstraint.activate([
            currentActivityVCView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            currentActivityVCView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            currentActivityVCView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            currentActivityVCView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            currentActivityVCView.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        addChild(todaysActivityVC)
        todaysActivityVC.view.translatesAutoresizingMaskIntoConstraints = false

        let todayActivityVCView: UIView = todaysActivityVC.view
        todayActivityVCView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(todayActivityVCView)
        
        NSLayoutConstraint.activate([
            todayActivityVCView.heightAnchor.constraint(equalToConstant: 800),
            todayActivityVCView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            todayActivityVCView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            todayActivityVCView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            todayActivityVCView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            todayActivityVCView.topAnchor.constraint(equalTo: currentActivityVCView.bottomAnchor, constant: 20),
        ])
    }
    
    fileprivate lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)), for: .normal)
//        rightButton.tintColor = .orange
        rightButton.tag = 1
        rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 50, height: 20)
        return rightButton
    }()
    
    fileprivate func createAddButton() {
        navigationController?.navigationBar.addSubview(rightButton)
        let targetView = self.navigationController?.navigationBar
        let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        
        let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -10)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        func animate(_ alpha: Int){
            UIView.animate(withDuration: 0.25, delay: 0, options: .transitionCrossDissolve, animations: {
                self.rightButton.alpha = CGFloat(alpha)
            })
        }
        
        if let height = navigationController?.navigationBar.frame.size.height, height == 44 {
            animate(0)
        } else {
            animate(1)
        }
    }
}
