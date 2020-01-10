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
    lazy var fpc: FloatingPanelController = {
        // Initialize a `FloatingPanelController` object.
        let fpc = FloatingPanelController()
        fpc.surfaceView.backgroundColor = .clear
        
        if #available(iOS 11, *) {
            fpc.surfaceView.cornerRadius = 9.0
        } else {
            fpc.surfaceView.cornerRadius = 0.0
        }
        
        fpc.surfaceView.shadowHidden = false
        return fpc
    }()
    
    var contentVC: NewActivityFloatingPanelViewController!
    
    static let sharedInstance = NewActivityViewController()
    
    @IBOutlet weak var newActivityOpeningText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var activityAttributes = [ActivityAttribute]([
        ActivityAttribute(title: "Name", placeholder: "Enter a name", data: nil)
    ])
    
    func createActivityAttribute(title: String) {
//        collapseFPC()
        
//        if let fpc = self.fpc {
//            print(fpc)
//        }
//        activityAttributes.append(ActivityAttribute(title: title!, placeholder: "Enter a \(title!.lowercased())", data: nil))
//        let newIndexPath = IndexPath(item: activityAttributes.count, section: 0)
//        self.collectionView.insertItems(at: [newIndexPath])
//        print(self.collectionView)
    }
    
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
        
        fpc.delegate = self
        
        contentVC = NewActivityFloatingPanelViewController()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.collectionView)
        fpc.addPanel(toParent: self)
        
        collectionView.layer.backgroundColor = .none
        collectionView.register(UICollectionViewButtonFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionViewButtonFooter.identifier)
        collectionView.register(UICollectionUserInputView.self, forCellWithReuseIdentifier: UICollectionUserInputView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        
        // FIXME: THiS SEEMS TO BREAK CELL TAP ON THE FLOATINGPANEL AS WELL
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
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
    
    @objc func collapseFPC() {
        fpc.move(to: .tip, animated: true)
    }
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            contentVC.searchBar.setShowsCancelButton(false, animated: true)
            contentVC.searchBar.resignFirstResponder()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset

        // Here you can set dynamic height for the individual cell according to your content size.
        let referenceHeight: CGFloat = 75 // Approximate height of your cell

        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right

        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionViewButtonFooter.identifier, for: indexPath) as? UICollectionViewButtonFooter
            sectionFooter?.button.addTarget(self, action: #selector(expandFPC), for: .touchUpInside)
            return sectionFooter!
        default:
            return UICollectionReusableView()
        }
    }
    
}
