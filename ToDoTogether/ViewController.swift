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
        loadData()
        checkForUpdates()
        
    }
    
    func loadData() {
        db.collection("todos").getDocuments { snapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                
                for document in snapshot!.documents {
                    let data = document.data()
                    if let toDo = ToDo(dictionary: data) {
                        
                        self.toDoArray.append(toDo)
                    }
                    print(type(of: data))
                    print(data)

                }
                
                self.toDoArray = snapshot!.documents.compactMap({ToDo(dictionary: $0.data())})
                print("Success getting the data", self.toDoArray.count)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func checkForUpdates() {
        db.collection("todos").whereField("timeStamp", isGreaterThan: Date())
            .addSnapshotListener { snapshot, error in
                
                guard let snapshot = snapshot else {
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        self.toDoArray.append(ToDo(dictionary: diff.document.data())!)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        
    }
    
    @IBAction func composeToDo(_ sender: UIBarButtonItem) {
        let composeAlert = UIAlertController(title: "New To Do", message: "What to do next?", preferredStyle: .alert)
        
        composeAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter your suggestion ;)"
        }
        
        composeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        composeAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            // SEND
            
            if let content = composeAlert.textFields?.first?.text {
                let newToDO = ToDo(content: content, timeStamp: Date())
                
                var ref: DocumentReference? = nil
                ref = self.db.collection("todos").addDocument(data: newToDO.dictionary) {
                    error in
                    
                    if let error = error {
                        print("Error adding doc ", error.localizedDescription)
                    } else {
                        print("Success adding id ", ref?.documentID ?? "")
                    }
                }
            }
        }))
        
        self.present(composeAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = "\(toDoArray[indexPath.row].content), \(toDoArray[indexPath.row].timeStamp)"
        return cell
    }
    
    
    
    
}

