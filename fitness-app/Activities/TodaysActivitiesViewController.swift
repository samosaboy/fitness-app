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
    
    var activities = [Excersize]([
        Excersize(title: "Barbell Bench Press", reps: 5, sets: 3, duration: 12, color: .blue),
        Excersize(title: "Flat Bench Dumbbell Press", reps: 5, sets: 3, duration: 12, color: .purple),
        Excersize(title: "Dips", reps: 5, sets: 3, duration: 12, color: .green),
        Excersize(title: "Cable Fly", reps: 5, sets: 3, duration: 12, color: .yellow),
        Excersize(title: "Back Extension", reps: 5, sets: 3, duration: 12, color: .common),
    ])
    
    func createActivity(activity: Excersize) -> GradientView {
        let workout = GradientView()
        workout.heightAnchor.constraint(equalToConstant: 75).isActive = true
        workout.topColor = activity.grad1!
        workout.bottomColor = activity.grad2!
        workout.cornerRadius = 12
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = activity.title
        
        let description = UIStackView(arrangedSubviews: [])
        description.translatesAutoresizingMaskIntoConstraints = false
        description.distribution = .fillEqually
        description.spacing = 8
        
        let sets = UILabel()
        sets.textColor = .white
        sets.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .regular)
        sets.translatesAutoresizingMaskIntoConstraints = false
        sets.text = "\(String(activity.sets)) sets"
        
        let reps = UILabel()
        reps.textColor = .white
        reps.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .regular)
        reps.translatesAutoresizingMaskIntoConstraints = false
        reps.text = "\(String(activity.reps)) reps"
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        description.addArrangedSubview(reps)
        description.addArrangedSubview(sets)
        
        container.addSubview(label)
        container.addSubview(description)
        
        workout.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: workout.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: workout.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: workout.trailingAnchor, constant: -8),
            
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: description.topAnchor),
            
            description.topAnchor.constraint(equalTo: label.bottomAnchor),
            description.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            description.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        ])
        
        return workout
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
        
//        var subViews: [UIView] = []
        
        if activities.count == 0 {
            let emptyContent = UILabel()
            emptyContent.translatesAutoresizingMaskIntoConstraints = false
            emptyContent.text = "You have no activities"
            emptyContent.textColor = .lightGray
            emptyContent.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .regular)
            tileFooter.addSubview(emptyContent)
            
            NSLayoutConstraint.activate([
                emptyContent.leadingAnchor.constraint(equalTo: tileFooter.leadingAnchor, constant: 20),
                emptyContent.trailingAnchor.constraint(equalTo: tileFooter.trailingAnchor, constant: -20),
                emptyContent.topAnchor.constraint(equalTo: tileFooter.topAnchor),
                emptyContent.bottomAnchor.constraint(lessThanOrEqualTo: tileFooter.bottomAnchor, constant: -20),
            ])
        } else {
//            for activity in activities {
//                let activityView = createActivity(activity: activity)
//                subViews.append(activityView)
//            }
//
            
            let _view: UIView = todaysActivitiesTableViewController.view
            _view.heightAnchor.constraint(equalToConstant: 75 * 5 + (5 * 5)).isActive = true
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
        }
        
        
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
            let todaysActivities = createTodaysActivities()
            cell?.contentView.addSubview(todaysActivities)
            cell?.contentView.layoutMargins.right = 20

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
        
        let rightButton = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightButton.text = "Edit"
        rightButton.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .regular)
        rightButton.textColor = .systemRed
        //        rightButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline)), for: .normal)
        //        rightButton.tag = 2
        
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
        //        switch indexPath.section {
        //        case 0:
        //            return 100
        //        default:
        return UITableView.automaticDimension
        //        }
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
