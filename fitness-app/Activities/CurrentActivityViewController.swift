//
//  CurrentActivityViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-28.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

class CurrentActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    var headerCell: UITableViewCell?
    
    func createCurrentActivity() -> UIView {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let currentActivityLabel = UILabel()
        currentActivityLabel.text = "Back Extension"
        currentActivityLabel.tintColor = .systemRed
        
        let currentActivityView = DataTypeTileHeaderView(image: UIImage(systemName: "waveform.path.ecg")!, label: currentActivityLabel, detailedTextLabel: "2 mins left")
        
        let timeEstimatesView = UIView()
        timeEstimatesView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(currentActivityView.view)
        view.addArrangedSubview(timeEstimatesView)
        
        
        NSLayoutConstraint.activate([
            currentActivityView.view.heightAnchor.constraint(equalToConstant: 50),
            currentActivityView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentActivityView.view.topAnchor.constraint(equalTo: view.topAnchor),
            currentActivityView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timeEstimatesView.topAnchor.constraint(equalTo: currentActivityView.view.bottomAnchor)
        ])
        
        let statView = UIStackView()
        statView.sizeToFit()
        statView.translatesAutoresizingMaskIntoConstraints = false
        statView.distribution = .fillEqually
        
        let currentWeight = createStat(statCount: "75.0", statLabel: "lbs")
        let currentReps = createStat(statCount: "5", statLabel: "reps")
        let currentSets = createStat(statCount: "3", statLabel: "sets")
        timeEstimatesView.addSubview(statView)
        
        statView.addArrangedSubview(currentReps)
        statView.addArrangedSubview(currentSets)
        statView.addArrangedSubview(currentWeight)
        
        NSLayoutConstraint.activate([
            statView.centerYAnchor.constraint(equalTo: timeEstimatesView.centerYAnchor),
            statView.heightAnchor.constraint(equalToConstant: 35),
            statView.leadingAnchor.constraint(equalTo: timeEstimatesView.leadingAnchor, constant: 20),
            statView.trailingAnchor.constraint(equalTo: timeEstimatesView.trailingAnchor, constant: -20),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
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
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "Add 30 seconds"
                cell?.textLabel?.textColor = .systemBlue
            default:
                cell?.accessoryType = .disclosureIndicator
                cell?.textLabel?.text = "Skip activity"
                cell?.textLabel?.textColor = .systemRed
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sectionm \(section)"
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIStackView()
        sectionView.axis = .horizontal
        sectionView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Activity"
        
        //        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        //        rightButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline)), for: .normal)
        //        rightButton.tag = 2
        
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
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .insetGrouped)
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
