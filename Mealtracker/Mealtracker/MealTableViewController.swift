//
//  MealTableViewController.swift
//  Mealtracker
//
//  Created by Student on 18/08/25.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals: [Meal]{
        let breakfast=Meal(name: "Breakfast", food: [Food(name: "oats", description: "full of fiber and protien"),Food(name: "Prantha", description: "High energy")])
        let lunch=Meal(name: "Lunch", food: [Food(name: "Veggie Salad", description: "full of fiber"),Food(name: "Shahi Paneer", description: "Full Protein")])
        let dinner=Meal(name: "Dinner", food: [Food(name: "Rice", description: "Fill your tummy")])
        return [breakfast,lunch,dinner]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].food.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        content.text = "\(meals[indexPath.section].food[indexPath.row].name)"

        content.secondaryText="\(meals[indexPath.section].food[indexPath.row].description)"
        cell.contentConfiguration = content


        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].name
    }

}
