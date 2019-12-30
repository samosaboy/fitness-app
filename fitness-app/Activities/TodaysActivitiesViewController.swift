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
    
    func createActivity(name: String, gradient1: UIColor, gradient2: UIColor) -> GradientView {
        let workout = GradientView(frame: CGRect(x: 0, y: 0, width: 30, height: 100))
        workout.translatesAutoresizingMaskIntoConstraints = false
        workout.topColor = gradient1
        workout.bottomColor = gradient2
        workout.cornerRadius = 8
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        
        workout.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: workout.leadingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: workout.topAnchor),
            label.bottomAnchor.constraint(equalTo: workout.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: workout.trailingAnchor, constant: -8),
        ])
        
        return workout
    }
    
    func createCurrentActivity() -> UIView {
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
        
        let workout1 = createActivity(name: "Barbell Bench Press", gradient1: UIColor(named: "appOrange")!, gradient2: UIColor(named: "appYellow")!)
        let workout2 = createActivity(name: "Flat Bench Dumbbell Press", gradient1: UIColor(named: "appPurple")!, gradient2: UIColor(named: "appPurpleBlue")!)
        let workout3 = createActivity(name: "Dips", gradient1: UIColor(named: "appGreen")!, gradient2: UIColor(named: "appGreenLight")!)
        let workout4 = createActivity(name: "Cable Fly", gradient1: UIColor(named: "appBlue")!, gradient2: UIColor(named: "appBlueLight")!)
        let workout5 = createActivity(name: "Back Extension", gradient1: UIColor(named: "appPurple")!, gradient2: UIColor(named: "appPurpleBlue")!)

        let statView = UIStackView(arrangedSubviews: [workout1, workout2, workout3, workout4, workout5])
        statView.spacing = 15
        statView.axis = .vertical
        statView.translatesAutoresizingMaskIntoConstraints = false
        statView.distribution = .fillEqually
        
        tileFooter.addSubview(statView)
        
        NSLayoutConstraint.activate([
            statView.leadingAnchor.constraint(equalTo: tileFooter.leadingAnchor, constant: 20),
            statView.trailingAnchor.constraint(equalTo: tileFooter.trailingAnchor, constant: -20),
            statView.topAnchor.constraint(equalTo: tileFooter.topAnchor),
            statView.bottomAnchor.constraint(equalTo: tileFooter.bottomAnchor, constant: -20),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func createStat(statCount: String, statLabel: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let count = UILabel()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .semibold)
        count.text = statCount
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .medium)
        label.textColor = .systemGray
        label.text = statLabel
        
        view.addSubview(count)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: count.trailingAnchor, constant: 3),
            label.lastBaselineAnchor.constraint(equalTo: count.lastBaselineAnchor),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "DataCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "DataCell")
        }
        
        switch indexPath.section {
        case 0:
            let currentActivity = createCurrentActivity()
            cell?.contentView.addSubview(currentActivity)
            cell?.contentView.layoutMargins.right = 20
            
            NSLayoutConstraint.activate([
                currentActivity.leadingAnchor.constraint(equalTo: cell!.contentView.leadingAnchor),
                currentActivity.trailingAnchor.constraint(equalTo: cell!.contentView.trailingAnchor),
                currentActivity.bottomAnchor.constraint(equalTo: cell!.contentView.bottomAnchor),
                currentActivity.topAnchor.constraint(equalTo: cell!.contentView.topAnchor),
            ])
        default:
            cell?.textLabel?.text = "Edit todays activities"
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
        
        sectionView.addArrangedSubview(label)
        
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
        switch indexPath.section {
        case 0:
            return 450
        default:
            return UITableView.automaticDimension
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
        tableView?.estimatedRowHeight = 150
        tableView?.isScrollEnabled = false
        
        self.view.addSubview(tableView!)
        
        NSLayoutConstraint.activate([
            tableView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}
