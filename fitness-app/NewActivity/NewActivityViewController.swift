//
//  NewActivityViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import UIKit
import FloatingPanel

class NewActivityViewController: UIViewController, UISearchBarDelegate, FloatingPanelControllerDelegate {
   
    var fpc: FloatingPanelController!
    var contentVC: NewActivityFloatingPanelViewController!

    @IBOutlet weak var newActivityButton: UIButton!
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CustomFloatingPanelLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Activity"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissNewActivityViewController(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Initialize a `FloatingPanelController` object.
        fpc = FloatingPanelController(delegate: self)
        
        fpc.surfaceView.backgroundColor = .clear
        if #available(iOS 11, *) {
            fpc.surfaceView.cornerRadius = 9.0
        } else {
            fpc.surfaceView.cornerRadius = 0.0
        }
        
        fpc.surfaceView.shadowHidden = false
        
        contentVC = NewActivityFloatingPanelViewController()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.collectionView)
        fpc.addPanel(toParent: self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        newActivityButton.tintColor = .systemBlue
        newActivityButton.setTitleColor(.systemBlue, for: .normal)
        newActivityButton.layer.cornerRadius = 15
        newActivityButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3)), for: .normal)
        newActivityButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        newActivityButton.backgroundColor = UIColor(named: "appButtonAlphaBlue")
        newActivityButton.addTarget(self, action: #selector(expandFPC), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        contentVC.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentVC.searchBar.delegate = self
    }
    
    @objc func dismissNewActivityViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove the views managed by the `FloatingPanelController` object from self.view.
        fpc.removePanelFromParent(animated: true)
    }
    
    // MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        fpc.move(to: .tip, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        contentVC.searchBar.setShowsCancelButton(true, animated: true)
        expandFPC()
    }
    
    @objc func expandFPC() {
        fpc.move(to: .full, animated: true)
    }
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            contentVC.searchBar.setShowsCancelButton(false, animated: true)
            contentVC.searchBar.resignFirstResponder()
        }
    }
}
