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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate(1)
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
    
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
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
        rightButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)), for: .normal)
        rightButton.tag = 1
        rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 50, height: 20)
        rightButton.addTarget(self, action: #selector(navigateToNewActivity(sender:)), for: .touchUpInside)
        return rightButton
    }()
    
    @objc func navigateToNewActivity(sender: UIButton!) {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewActivityStoryboard")
        let navigationController = UINavigationController(rootViewController: newViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    fileprivate func createAddButton() {
        navigationController?.navigationBar.addSubview(rightButton)
        let targetView = self.navigationController?.navigationBar
        let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -Const.ImageRightMargin)
        
        let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -Const.ImageBottomMarginForLargeState)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        rightButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func animate(_ alpha: Int){
        UIView.animate(withDuration: 0.15, delay: 0, options: .transitionCrossDissolve, animations: {
            self.rightButton.alpha = CGFloat(alpha)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
}
