//
//  NotesVC.swift
//  NotesKeeper 
//
//  Created by G50 on 5/14/20.
//  Copyright © 2020 NotesKeeper. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class NotesVC: UITableViewController {
    
    //MARK:- Constants
    var notesArr :[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        setUpUI()
        setUpPullToRefreshPod()

    }
    override func viewWillDisappear(_ animated: Bool) {
        
    //by using this line we finish the usage of the pod in this vc
        tableView.dg_removePullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
     //this func is called every time we enter the VC to make the pod still working
        setUpPullToRefreshPod()
    }
    
    //MARK:- Helper Functions
    func setUpUI(){
        
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        
     //Registering cells in tableview by their nib so that TV can know cell's location
       tableView.register(UINib(nibName: "toDoCell", bundle: nil), forCellReuseIdentifier: "toDoCell")
        tableView.reloadData()
    }
    
    func setUpNavigation() {
        self.title = "Notes"
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
    //Add btn as the rightBarBtnItem
        let AddNoteBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addBtnPressed))
        
        self.navigationItem.rightBarButtonItem = AddNoteBtn

    }
    
    func setUpPullToRefreshPod(){
    
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(#colorLiteral(red: 0.05045407647, green: 0.2297388561, blue: 0.3413865963, alpha: 1))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    @objc func addBtnPressed(){
        
        let AddNewNote = AddNewNoteVC()
        self.navigationController?.pushViewController(AddNewNote, animated: true)
        AddNewNote.delegate = self
    }
    
    @objc func upBtnPressed(_ sender: UIButton) {
       // swap the current cell item with the above of it if its not the first cell.
       // all these swaps are in the array itself which have the same index as the tableview indexPath

        if sender.tag != 0 {

            notesArr.swapAt(sender.tag, sender.tag - 1)
            print("up")
            //there is changes in the arr we want to notify the table View with it
            tableView.reloadData()
        }
            print("up")

    }

    @objc func downBtnPressed(_ sender: UIButton) {

        if sender.tag != notesArr.count - 1 {

          notesArr.swapAt(sender.tag, sender.tag + 1)
            print("down")
            //there is changes in the arr we want to notify the table View with it
           tableView.reloadData()
       }
               print("down")
   }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return notesArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! toDoCell
        
        //binding / displaying data on the cell components
        cell.labelOutlet.text = notesArr[indexPath.row].noteTitle
        cell.priorityValueLBL.text = notesArr[indexPath.row].notePriority
        //cell.delegate = self
        
        //passing the order in tableView & array of the current selected cell to be the tag or identifier of the up & down btns
      
        cell.upBtnOutlet.tag = indexPath.row
        cell.downBtnOutlet.tag = indexPath.row
        
        //we make AddTarget here for the btns outlets without IBActions in cellClass because the cell has no direct access to the notes Arr.
        // the up btn swaps the current cell with its above cell if it is not the first one
        
        cell.upBtnOutlet.addTarget(self, action: #selector(upBtnPressed(_:)), for: .touchUpInside)
        cell.downBtnOutlet.addTarget(self, action: #selector(downBtnPressed(_:)), for: .touchUpInside)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.SCREEN_HEIGHT / 8
    }
    
     //executing something when the cell is clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //when the cell is clicked we want a shadow with color to appear with each select as animation
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   //Adding Swipes to the tableview cells : the swipe is an Edit operation of the tableView cell/items
   //the edit can be a DELETE of a cell or any other operation to do.
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        //call this func to enable tableView cells editing
        return true
    }
    
    //Make left or right Swipes
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       //Making swipe actions
        let deleteAction = UIContextualAction(style: .normal , title: "Delete") { (action, view, handler) in
            
            self.notesArr.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
        //adding image to the contextual action
        deleteAction.image  = #imageLiteral(resourceName: "pin")
        deleteAction.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        
       //the func returns an object from the UISwipeActionConfiguration class , this class gathers all the swipe Actions together and then displays them .
       let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
       swipe.performsFirstActionWithFullSwipe = false
        
       return swipe
    }

}

//adapting to the protocol by implementing the functions of it
 extension NotesVC : AddNewNote{
    
    func addNewNote(note: Note) {
        
     // adding the object received from the AddNewNoteVC to the array
        notesArr.append(note)
        notesArr.sort{$0.notePriority < $1.notePriority}
        print(notesArr)
        tableView.reloadData()
    }
  }

//extension NotesVC : CellBtnsPressed {
//func upBtnClicked(tag: Int) {
//     if tag != 0{
//
//        notesArr.swapAt(tag, tag - 1)
//        tableView.reloadData()
//    }
// }
//
//    func downBtnClicked(tag: Int) {
//        if tag != notesArr.count - 1 {
//
//            notesArr.swapAt(tag, tag + 1)
//            tableView.reloadData()
//        }
//    }
//}
    
    
    
    



