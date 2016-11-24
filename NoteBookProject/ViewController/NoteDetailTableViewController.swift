//
//  NoteDetailTableViewController.swift
//  NoteBookProject
//
//  Created by imac on 23/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit
import RealmSwift

class NoteDetailTableViewController: UITableViewController {
    
    let realm = try! Realm()
    // Get the default Realm
    
   
    private var _subject:Subject?
    var subject: Subject? {
        get {
            return _subject
        }
        set {
            _subject = newValue
        }
    }
    func addNewNote(newNote:Note) {
        
        _subject?.addNote(comment: newNote.comment, value: newNote.value, range: newNote.range)
        print("suiszici")
        if tableView != nil {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(subject?.name) nom du sujet")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    @IBAction func unwindToNoteDetailVCbySave(for segue: UIStoryboardSegue) { //Action créée a la main //je pourrais recuperer mon object newSubject du AddSuject.. viewController ici si je voulais
        // update
        print ("unwindToVCbySave")
        
    }
    @IBAction func unwindToNoteDetailVCbyCancel(for segue: UIStoryboardSegue) { //Action créée a la main
        print ("unwindToVCbyCancel")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let zeSubject = _subject {
            return zeSubject.notesCount()
        } else {
            return 0
        }
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "notes-cell", for: indexPath)
     cell.textLabel?.text = _subject?.notesList[indexPath.row].comment
     cell.detailTextLabel?.text = _subject?.notesList[indexPath.row].comment
 
     
     // Configure the cell...
     
     return cell
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
