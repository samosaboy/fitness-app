//
//  ActivitiesViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-27.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(mainContentView)
        
        NSLayoutConstraint.activate([
            mainContentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            mainContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        createCurrentWorkout()
        createAddButton()
    }
    
    func createCurrentWorkout() {
        self.embed(CurrentActivityViewController(), inView: self.mainContentView)
    }
    
    func createAddButton() {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)), for: .normal)
        navigationController?.navigationBar.addSubview(rightButton)
        
        rightButton.tag = 1
        rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 50, height: 20)
        
        let targetView = self.navigationController?.navigationBar
        
        let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        
        let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -10)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
