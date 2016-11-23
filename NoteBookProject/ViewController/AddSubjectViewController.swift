//
//  AddSubjectViewController.swift
//  NoteBookProject
//
//  Created by imac on 21/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class AddSubjectViewController: UIViewController {
    
    private var _subject:Subject?
    
    @IBOutlet weak var coefSlider: UISlider!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var coefTextField: UILabel!
    
    var subject: Subject? {
        return _subject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = ""
        coefTextField.text = String(Int(coefSlider.value))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        
        switch unwindSegue.identifier! {
        case "unwindToVCbySave":
            if let zeNameTextField = nameTextField.text,
                zeNameTextField.characters.count > 0 {
                _subject = Subject(name: zeNameTextField, range: Int(coefSlider.value))
                print ("nouvelle matiere")
                
            } else {
                
                let alert = UIAlertController(title: "Alert", message: "nom de la matiere obligatoire", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
                }))
                // Present the controller
                self.present(alert, animated: true, completion: nil)
                
            }
            
            if let subject = _subject {
                let firstTableViewController:FirstTableViewController = unwindSegue.destination as! FirstTableViewController
                firstTableViewController.addNewSubject(newSubject: subject)
                print ("j ai ma matiere et je la passe")
                
            }
        case "unwindToVCbyCancel":
            print ("bye bye")
        default:
            break
            
        }
        
    }
    @IBAction func coeffValueChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        coefTextField.text = "\(currentValue)"
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
