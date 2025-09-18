//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Student on 16/9/2025.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var toDos = [ToDo] () // Array to store ToDo items

    // Load saved ToDos or use sample ToDos if no saved data
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
        
        // Add an Edit button to the navigation bar
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    // Return the number of ToDo items for the table view to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    // Dequeue a reusable cell and populate it with ToDo data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! ToDoCell
        
        let toDo = toDos[indexPath.row]
        cell.delegate = self
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        
        return cell
    }
  
    // Allow rows to be editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Handle row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos) // Save updated ToDos
        }
    }

    // Handle unwind segue from ToDoDetailTableViewController
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
           ToDoDetailTableViewController
    
        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
                // Update existing ToDo if it exists
                toDos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                // Add new ToDo if it doesn't exist
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(toDos) // Save updated ToDos
    }
    
    // Handle the checkmark button tap to mark a ToDo as complete or incomplete
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = toDos[indexPath.row]
            toDo.isComplete.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos) // Save updated ToDos
        }
    }
    
    // Prepare for editing a ToDo by passing the data to ToDoDetailTableViewController
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return detailController }
        
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        
        return detailController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
