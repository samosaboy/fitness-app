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
    
    lazy var timeEstimatesView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var currentActivity: UITableViewCell = {
        let currentActivity = UITableViewCell(style: .value1, reuseIdentifier: "ActiveCell")
        currentActivity.translatesAutoresizingMaskIntoConstraints = false
        currentActivity.imageView?.image = UIImage(systemName: "waveform.path.ecg")
        currentActivity.imageView?.tintColor = .systemRed
        currentActivity.textLabel?.text = "Back Extension"
        currentActivity.textLabel?.textColor = .systemRed
        currentActivity.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .medium)
        currentActivity.detailTextLabel?.text = "8:39 PM"
        currentActivity.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .regular)
        currentActivity.accessoryType = .disclosureIndicator
        return currentActivity
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func createStat(statCount: String, statLabel: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let count = UILabel()
        count.sizeToFit()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .semibold)
        count.text = statCount
        
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .medium)
        label.textColor = .systemGray
        label.text = statLabel
        
        view.addSubview(count)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: count.trailingAnchor, constant: 3),
            label.bottomAnchor.constraint(equalTo: count.bottomAnchor, constant: -2.5),
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
        
        if cell?.contentView.subviews.count == 0 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(currentActivity)
            cell?.contentView.addSubview(view)
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: cell!.contentView.topAnchor),
                view.bottomAnchor.constraint(equalTo: cell!.contentView.bottomAnchor),
                view.centerXAnchor.constraint(equalTo: cell!.contentView.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: cell!.contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: cell!.contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: cell!.contentView.trailingAnchor),
                
                currentActivity.topAnchor.constraint(equalTo: view.topAnchor),
                currentActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                currentActivity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                currentActivity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
            let statView = UIStackView()
            statView.translatesAutoresizingMaskIntoConstraints = false
            statView.distribution = .fillEqually
            
            let weightCount = createStat(statCount: "210", statLabel: "lbs")
            let repCount = createStat(statCount: "5", statLabel: "reps")
            let setCount = createStat(statCount: "5", statLabel: "sets")
            
            statView.addArrangedSubview(weightCount)
            statView.addArrangedSubview(repCount)
            statView.addArrangedSubview(setCount)
            
            view.addSubview(statView)
            
            NSLayoutConstraint.activate([
                statView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                statView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                statView.heightAnchor.constraint(equalToConstant: 50),
                statView.topAnchor.constraint(equalTo: currentActivity.bottomAnchor),
                statView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
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
        label.text = "Current Activity"
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline)), for: .normal)
        rightButton.tag = 2
        
        sectionView.addArrangedSubview(label)
        sectionView.addArrangedSubview(rightButton)
        
        return sectionView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return currentActivity.frame.height * 2.3
        //        return UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300), style: .insetGrouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 150
        
        self.view.addSubview(tableView!)
    }
    
}
