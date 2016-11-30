//
//  AddNoteViewController.swift
//  NoteBookProject
//
//  Created by imac on 24/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickOption = ["1","2", "3","4","5","6","7","8","9","10"]
    
    @IBOutlet weak var picketTextField: UITextField!
    private var _note:Note?
    var note: Note? {
        return _note
    }
    @IBOutlet weak var ui_noteName_textField: UITextField!
    @IBOutlet weak var ui_coef_label: UILabel!
    @IBOutlet weak var ui_coef_slider: UISlider!
    // Put this piece of code anywhere you like
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picketTextField.text = pickOption[row]
      
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()

        picketTextField.inputView = pickerView
        ui_noteName_textField.text = ""
        ui_coef_label.text = String(Int(ui_coef_slider.value))

        // Do any additional setup after loading the view.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        
        switch unwindSegue.identifier! {
        case "unwindToNoteDetailVCbySave":
            if let zeNameTextField = ui_noteName_textField.text,
                zeNameTextField.characters.count > 0 {
                _note = Note(comment: zeNameTextField, value: 1, range: Int(ui_coef_slider.value)) // a finir la valeur
                print ("nouvelle matiere")
                
            } else {
                
                let alert = UIAlertController(title: "Alert", message: "nom de la matiere obligatoire", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
                }))
                // Present the controller
                self.present(alert, animated: true, completion: nil)
                
            }
            
            if let note = _note {
                let noteDetailTableViewController:NoteDetailTableViewController = unwindSegue.destination as! NoteDetailTableViewController
                noteDetailTableViewController.addNewNote(newNote: note)
                print ("j ai ma note et je la passe")
                
            }
        case "unwindToNoteDetailVCbyCancel":
            print ("bye bye")
        default:
            break
            
        }
        
    }
    
    @IBAction func coefValueChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        ui_coef_label.text = "\(currentValue)"
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
