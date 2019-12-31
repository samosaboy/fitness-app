//
//  TodaysActivitiesTableViewController.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-31.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

struct Excersize {
    var title: String
    var reps: Int
    var sets: Int
    var duration: Int
    
    // for color picker
    var color: ActivityColorsEnum
    
    var grad1: UIColor?
    var grad2: UIColor?
    
    init(title: String, reps: Int, sets: Int, duration: Int, color: ActivityColorsEnum) {
        self.title = title
        self.reps = reps
        self.sets = sets
        self.duration = duration
        self.color = color
        
        let colorGradients = UIColor.ActivityColors(color: color)
        
        self.grad1 = colorGradients.color[0]
        self.grad2 = colorGradients.color[1]
    }
}

class TodaysActivitiesTableViewController: UITableViewController {
    
    var activities = [Excersize]([
        Excersize(title: "Barbell Bench Press", reps: 5, sets: 3, duration: 12, color: .blue),
        Excersize(title: "Flat Bench Dumbbell Press", reps: 5, sets: 3, duration: 12, color: .purple),
        Excersize(title: "Dips", reps: 5, sets: 3, duration: 12, color: .green),
        Excersize(title: "Cable Fly", reps: 5, sets: 3, duration: 12, color: .yellow),
        Excersize(title: "Back Extension", reps: 5, sets: 3, duration: 12, color: .common),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .none
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.tableView.rowHeight = 100
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActivityCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        cell.backgroundColor = .none
        
        let view = createActivity(activity: activities[indexPath.row])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            view.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5),
        ])
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
