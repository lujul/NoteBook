//
//  FirstTableViewController.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit
import RealmSwift

class FirstTableViewController: UITableViewController {
    
    var realm = try! Realm()
    // Get the default Realm
    var subjectsRealmList:Results<Subject> = try! Realm().objects(Subject.self) //tout le temps a jour qd on l appelle
    let user: User = User()
    private static let SERVER_IP = "192.168.1.42:9080"
    var _notificationToken:NotificationToken!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.tableView != nil {
            self.tableView.reloadData()
        }
       prepareRealm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //  self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func realmConnected(withUser user:SyncUser) {
        // can now open a synchronized Realm with this user
        let syncServerURL = URL(string: "realm://\(FirstTableViewController.SERVER_IP)/~/julienRealm")!
        let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: syncServerURL))
        
        // Open the remote Realm
        realm = try! Realm(configuration: config)
        subjectsRealmList = realm.objects(Subject.self)
        _notificationToken =  subjectsRealmList.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
        
    }
    
    func prepareRealm() {
        let serverURL = NSURL(string: "http://\(FirstTableViewController.SERVER_IP)")!
        let usernameCredentials = SyncCredentials.usernamePassword(username: "julien3b@gmail.com", password: "toto")
        SyncUser.logIn(with: usernameCredentials,
                       server:serverURL as URL) { user, error in
                        if let user = user {
                            DispatchQueue.main.async {
                                self.realmConnected(withUser: user)
                            }
                        } else if let error = error {
                            // handle error
                            print("REALM : error \(error)")
                        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func addNewSubject(newSubject:Subject) {
        //user.addSubject ...(correction)
        try! realm.write {
            realm.add(newSubject)
        }
        
       // if tableView != nil {
         //   self.tableView.reloadData()
        //}
    }
    
    @IBAction func unwindToVCbySave(for segue: UIStoryboardSegue) { //Action créée a la main //je pourrais recuperer mon object newSubject du AddSuject.. viewController ici si je voulais
        // update
        print ("unwindToVCbySave")
        
    }
    @IBAction func unwindToVCbyCancel(for segue: UIStoryboardSegue) { //Action créée a la main
        print ("unwindToVCbyCancel")
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        print ("canPerformUnwindSegueAction")
        return true
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
       //user.getSubjectCount (correction)
        return subjectsRealmList.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subject-note" {
            if let cell = sender as? UITableViewCell{
                if let indexPath = self.tableView.indexPath(for: cell) {
                    //user.getSubject (correction)
                    let selectedSubject = subjectsRealmList[indexPath.row]
                    let noteDetailViewController:NoteDetailTableViewController = segue.destination as! NoteDetailTableViewController
                    noteDetailViewController.subject = selectedSubject
                    // on ajoute l objet au vueController
                }
            }
        }
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subject-tableView", for: indexPath)
        //user.getSubjectAtIndex (correction)
        cell.textLabel?.text = subjectsRealmList[indexPath.row].getTitle()
        cell.detailTextLabel?.text = "Coef:\(subjectsRealmList[indexPath.row].getRange())"
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            //user.deleteSubject(at (correction)
           let subjectToDelete = subjectsRealmList[indexPath.row]
           try! realm.write {
                realm.delete(subjectToDelete)
            }
           //tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

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
