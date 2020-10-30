//
//  AddNewNoteVC.swift
//  NotesKeeper
//
//  Created by G50 on 5/13/20.
//  Copyright © 2020 NotesKeeper. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift

protocol AddNewNote {
    func addNewNote(note : Note)
}

class AddNewNoteVC: UIViewController {
  
//MARK:-IBOutlets

    @IBOutlet weak var addToDoTF: UITextField!
    @IBOutlet weak var addToDoBtn: UIButton!
    @IBOutlet weak var notePriorityTF: UITextField!
    
    //MARK:- Constants
    var delegate: AddNewNote?
    var note : Note!
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New Note"
    }
    
    //we want to access the executed func everytime when we leave this VC
    override func viewWillDisappear(_ animated: Bool) {
        
        if flag == 1 {
            delegate?.addNewNote(note: note!)
            flag = 0
        }
    }
    
    
//MARK:- IBActions
    
    
    @IBAction func AddBtnPressed(_ sender: UIButton) {
        if addToDoTF.text != "" && notePriorityTF.text != "" {
            
           note = Note(noteTitle: addToDoTF.text!, notePriority: notePriorityTF.text!)
           flag = 1
            
        // we want after adding data & pressing the add btn to return back automatically to previous VC without press the back Btn
            self.navigationController?.popViewController(animated: true)
        }else{
        // if the textFields are empty we will  show alertController for messaging the user and notify him
            let alert = UIAlertController(title: "Error", message: "Please fill empty fields!", preferredStyle: .alert)
            
            //cancel btn will dismiss the alert only
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            //default action can also dismisses the alert or making any thing else executd in its closure
            let defaultAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
                self.dismiss(animated: true, completion: nil)
            }
            
            
            //Destructive type is necessary when handling with serious actions which should take a user confirmation of it such as deleting user's data
            let destructiveAction = UIAlertAction(title: "delete", style: .destructive, handler: nil)
            
            //adding the action btns to the alert controller
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            alert.addAction(destructiveAction)

            //displaying the UIAlertController by using present
            self.present(alert, animated: true, completion: nil)
        }
      
    }
    
    
//MARK:- Helper Functions
    
    
    
    
    
    


}
