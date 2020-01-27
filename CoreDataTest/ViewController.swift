//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Sabbir Hossain on 1/23/20.
//  Copyright © 2020 Code-X Systems. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var showDataTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var ageTextView: UITextField!
    var textFieldString : String = ""
    var people = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showAllPerson()
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let name = nameTextView.text
        let age = ageTextView.text
        
        print(name as Any)
        print(age as Any)
        
        let person = People(context: PersistenceService.context)
        person.name = name
        person.age = Int16(age!)!
        PersistenceService.saveContext()
        print("From DB - ")
        showAllPerson()
        
    }
    
    // Function for fetching and showing data
    func showAllPerson() {
        
        textFieldString = ""
        let fetchRequest : NSFetchRequest<People> = People.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            for item in people {
                print("Name: \(item.name as Any) \nAge: \(item.age as Any)")
                
                // Appending to the string
                self.textFieldString += "Name: " + item.name! + ": " + "Age: " + String(item.age) + "\n"
            }
            
            // Show in textview
            showDataTextView.text = textFieldString
            
        } catch {
            print("Failed to fetch")
        }
    }
}

