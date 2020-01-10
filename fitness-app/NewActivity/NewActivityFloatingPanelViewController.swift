//
//  NewActivityFloatingPanelViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import UIKit

struct Modifier {
    var title: String
    var color: UIColor
}

class NewActivityFloatingPanelViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing:CGFloat = 16.0
    
    var modifiers = [Modifier]([
        Modifier(title: "Reps", color: .systemGray5),
        Modifier(title: "Sets", color: .systemGray5),
        Modifier(title: "Duration", color: .systemGray5),
        Modifier(title: "Break", color: .systemGray5),
        Modifier(title: "Stretch", color: .systemGray5),
    ])
    
    var attributes = [Modifier]([
        Modifier(title: "Color", color: .systemGray5),
        Modifier(title: "Note", color: .systemGray5),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.delaysContentTouches = false
        
        collectionView.register(NewActivityCell.self, forCellWithReuseIdentifier: NewActivityCell.identifier)
        collectionView.register(UICollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionViewSectionHeader.identifier)
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 40, right: 20)
            collectionViewLayout.invalidateLayout()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return attributes.count
        default:
            return modifiers.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NewActivityCell.identifier, for: indexPath) as! NewActivityCell
        var data = self.modifiers[indexPath.item]
        
        switch indexPath.section {
        case 0:
            data = self.attributes[indexPath.item]
            break
        case 1:
            data = self.modifiers[indexPath.item]
            break
        default:
            break
        }
        
        cell.textLabel.text = data.title
        cell.contentView.backgroundColor = data.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionViewSectionHeader.identifier, for: indexPath) as? UICollectionViewSectionHeader
            
            switch indexPath.section {
            case 0:
                sectionHeader?.label.text = "Attributes"
                sectionHeader?.sectionDescription.text = "Custom attributes such as color"
            case 1:
                sectionHeader?.label.text = "Modifiers"
                sectionHeader?.sectionDescription.text = "Modifiers create more detailed activities, such as the number of reps you want to do."
            default:
                break
            }
            
            return sectionHeader!
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(item: 0, section: section)
        
        if let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? UICollectionViewSectionHeader {
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                             height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .fittingSizeLevel)
        }
        
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing) / numberOfItemsPerRow
            return CGSize(width: width, height: width)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = modifiers.remove(at: sourceIndexPath.item)
        modifiers.insert(temp, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NewActivityCell?
//        NewActivityViewController.sharedInstance.collapseFPC()
        NewActivityViewController.sharedInstance.createActivityAttribute(title: cell!.textLabel.text!)
    }
}

extension NewActivityFloatingPanelViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cell = modifiers[indexPath.row]
        let item = NSItemProvider(object: cell.title as NSString)
        let dragItem = UIDragItem(itemProvider: item)
        dragItem.localObject = cell
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let cell = collectionView.cellForItem(at: indexPath) as! NewActivityCell
        let preview = UIDragPreviewParameters()
        let path = UIBezierPath(roundedRect: cell.contentView.frame, cornerRadius: 12)
        preview.visiblePath = path
        preview.backgroundColor = .clear
        return preview
    }
}
