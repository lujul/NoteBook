//
//  SecondViewController.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit
import RealmSwift
class SecondViewController: UIViewController {
    private static let SERVER_IP = "192.168.1.42:9080"
    var _notificationToken:NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create the configuration
        let serverURL = NSURL(string: "http://\(SecondViewController.SERVER_IP)")!
        let usernameCredentials = SyncCredentials.usernamePassword(username: "julien3b@gmail.com", password: "toto")
        SyncUser.logIn(with: usernameCredentials,
                       server:serverURL as URL) { user, error in
                        if let user = user {
                            DispatchQueue.main.async {
                                // can now open a synchronized Realm with this user
                                let syncServerURL = URL(string: "realm://\(SecondViewController.SERVER_IP)/~/userRealm")!
                                let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: syncServerURL))
                                
                                // Open the remote Realm
                                let realm = try! Realm(configuration: config)
                                // Any changes made to this Realm will be synced across all devices!
                                print("connexion ouverte")
                                
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
    
    
}

