//
//  ViewController.swift
//  ToDoTogether
//
//  Created by Emre Dogan on 04/04/2022.
//

import UIKit
import FirebaseFirestore

class ViewController: UITableViewController {
    
    
    var db: Firestore!
    var toDoArray = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
       
    }
    @IBAction func composeToDo(_ sender: UIBarButtonItem) {
        let composeAlert = UIAlertController(title: "New To Do", message: "What to do next?", preferredStyle: .alert)
        
        composeAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter your suggestion ;)"
        }
        
        composeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        composeAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            // SEND
        }))
        
        self.present(composeAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoArray[indexPath.row].content
        return cell
    }
    
    


}

