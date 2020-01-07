//
//  NewActivityViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import UIKit
import FloatingPanel

struct ActivityAttribute {
    var title: String
    var placeholder: String
    var data: String?
}

class NewActivityViewController: UIViewController, UISearchBarDelegate, FloatingPanelControllerDelegate {
    var fpc: FloatingPanelController!
    var contentVC: NewActivityFloatingPanelViewController!
    
    @IBOutlet weak var newActivityOpeningText: UILabel!
    @IBOutlet weak var newActivityUserInputCollectionView: UICollectionView!
    
    var activityAttributes = [ActivityAttribute]([
        ActivityAttribute(title: "Name", placeholder: "Enter a name", data: nil)
    ])
    
    lazy var addButton: UICollectionViewCell = {
        let cell = UICollectionViewCell()
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3)), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.backgroundColor = UIColor(named: "appButtonAlphaBlue")
        button.addTarget(self, action: #selector(expandFPC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            button.topAnchor.constraint(equalTo: cell.topAnchor),
            button.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        ])
        
        return cell
    }()
    
    func createActivityInput() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey"
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        return view
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CustomFloatingPanelLayout()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return FloatingPanelStocksBehavior()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Activity"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissNewActivityViewController(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
                
        newActivityUserInputCollectionView.layer.backgroundColor = .none
        newActivityUserInputCollectionView.register(UICollectionUserInputView.self, forCellWithReuseIdentifier: UICollectionUserInputView.identifier)
        newActivityUserInputCollectionView.dataSource = self
        newActivityUserInputCollectionView.delegate = self
        
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
                
        
        //        let nameInput = createActivityInput()
        //
        //        view.addSubview(nameInput)
        //
        //        newActivityButton.translatesAutoresizingMaskIntoConstraints = false
        //
        //        NSLayoutConstraint.activate([
        //            nameInput.leadingAnchor.constraint(equalTo: newActivityOpeningText.leadingAnchor),
        //            nameInput.trailingAnchor.constraint(equalTo: newActivityOpeningText.trailingAnchor),
        //            nameInput.topAnchor.constraint(equalTo: newActivityOpeningText.bottomAnchor, constant: 20),
        //            nameInput.heightAnchor.constraint(equalToConstant: 100),
        //
        //            newActivityButton.leadingAnchor.constraint(equalTo: newActivityOpeningText.leadingAnchor),
        //            newActivityButton.trailingAnchor.constraint(equalTo: newActivityOpeningText.trailingAnchor),
        //            newActivityButton.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 20),
        //            newActivityButton.heightAnchor.constraint(equalToConstant: 50),
        //
        //        ])
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        newActivityUserInputCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension NewActivityViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityAttributes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionUserInputView.identifier, for: indexPath) as! UICollectionUserInputView
        let attribute = activityAttributes[indexPath.item]
        cell.textLabel.text = attribute.title.uppercased()
//        cell.textInputView.placeholder = attribute.placeholder
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 20, left: 10, bottom: 20, right: 10)
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 20, height: 75)
    }
}
