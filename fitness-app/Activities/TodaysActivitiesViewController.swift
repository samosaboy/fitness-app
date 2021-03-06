//
//  TodaysActivitiesViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-29.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

class TodaysActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    var headerCell: UITableViewCell?
    
    let todaysActivitiesTableViewController = TodaysActivitiesTableViewController()
    
    lazy var rightButton: UILabel = {
        let rightButton = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightButton.isUserInteractionEnabled = true
        rightButton.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .regular)
        rightButton.textColor = .systemRed
        rightButton.tag = 2
        rightButton.text = "Edit"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleRightButtonClick(_:)))
        rightButton.addGestureRecognizer(tap)
        return rightButton
    }()
    
    @objc fileprivate func handleRightButtonClick(_ sender: UITapGestureRecognizer) {
        todaysActivitiesTableViewController.toggleEditMode(sender)
        updateEditButton()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createTodaysActivities() -> UIView {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Chest Day"
        label.tintColor = .systemRed
        
        let tileHeader = DataTypeTileHeaderView(image: UIImage(systemName: "calendar.circle.fill")!, label: label, detailedTextLabel: "1 hour estimated")
        
        let tileFooter = UIView()
        tileFooter.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(tileHeader.view)
        view.addArrangedSubview(tileFooter)
        
        NSLayoutConstraint.activate([
            tileHeader.view.heightAnchor.constraint(equalToConstant: 50),
            tileHeader.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tileHeader.view.topAnchor.constraint(equalTo: view.topAnchor),
            tileHeader.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tileFooter.topAnchor.constraint(equalTo: tileHeader.view.bottomAnchor)
        ])
        
        let _view: UIView = todaysActivitiesTableViewController.view
        var count = todaysActivitiesTableViewController.activities.count
        
        print("How many activities?", count)
        
        if (count == 0) {
            count = 1
        }
        
        _view.heightAnchor.constraint(equalToConstant: CGFloat(75 * count + (5 * count))).isActive = true
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        let statView = UIStackView(arrangedSubviews: [_view])
        statView.spacing = 10
        statView.axis = .vertical
        statView.translatesAutoresizingMaskIntoConstraints = false
        statView.alignment = .fill
        statView.distribution = .fill
        
        tileFooter.addSubview(statView)
        
        NSLayoutConstraint.activate([
            statView.leadingAnchor.constraint(equalTo: tileFooter.leadingAnchor, constant: 20),
            statView.trailingAnchor.constraint(equalTo: tileFooter.trailingAnchor, constant: -20),
            statView.topAnchor.constraint(equalTo: tileFooter.topAnchor),
            statView.bottomAnchor.constraint(lessThanOrEqualTo: tileFooter.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            tileFooter.topAnchor.constraint(equalTo: tileHeader.view.bottomAnchor),
            tileFooter.leadingAnchor.constraint(equalTo: tileHeader.view.leadingAnchor),
            tileFooter.trailingAnchor.constraint(equalTo: tileHeader.view.trailingAnchor),
            tileFooter.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layoutIfNeeded()
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "DataCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "DataCell")
        }
        
        switch indexPath.section {
        case 0:
            let todaysActivities = createTodaysActivities()
            cell?.contentView.addSubview(todaysActivities)
            
            NSLayoutConstraint.activate([
                todaysActivities.leadingAnchor.constraint(equalTo: cell!.contentView.leadingAnchor),
                todaysActivities.trailingAnchor.constraint(equalTo: cell!.contentView.trailingAnchor),
                todaysActivities.bottomAnchor.constraint(equalTo: cell!.contentView.bottomAnchor),
                todaysActivities.topAnchor.constraint(equalTo: cell!.contentView.topAnchor),
            ])
        default:
            cell?.textLabel?.text = "Skip Today"
            cell?.textLabel?.textColor = .systemRed
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sectionm \(section)"
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIStackView()
        sectionView.axis = .horizontal
        sectionView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Todays Activities"
        
        
        //rightButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline)), for: .normal)
        //rightButton.tag = 2
        
        sectionView.addArrangedSubview(label)
        sectionView.addArrangedSubview(rightButton)
        
        return sectionView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 35
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    fileprivate func updateEditButton() {
        DispatchQueue.main.async {
            if (self.todaysActivitiesTableViewController.tableView.isEditing) {
                self.rightButton.text = "Done"
            } else {
                self.rightButton.text = "Edit"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.backgroundColor = .none
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = false
        
        self.view.addSubview(tableView!)
        
        addChild(todaysActivitiesTableViewController)
        
        NSLayoutConstraint.activate([
            tableView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}
