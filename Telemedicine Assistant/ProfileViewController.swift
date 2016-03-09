//
//  ProfileViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 3/3/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var pregnantSwitch: UISwitch!
    @IBOutlet var allergenTextField: UITextField!
    
    var selectedProfile: Profile?
    var profiles = [Profile]()
    var isEdit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if isEdit == true {
            firstNameTextField.text = selectedProfile!.firstName
            lastNameTextField.text = selectedProfile!.lastName
            ageTextField.text = String(selectedProfile!.age)
            pregnantSwitch.setOn(selectedProfile!.pregnant == nil ? false : selectedProfile!.pregnant, animated: false)
            allergenTextField.text = selectedProfile!.allergen
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showCenter" {
            let firstName = firstNameTextField.text!
            let lastName = lastNameTextField.text!
            let age = Int(ageTextField.text!)
            let pregnant = pregnantSwitch.on
            let allergen = allergenTextField.text
            
            if firstName.isEmpty || lastName.isEmpty || age == nil {
                let alertController = UIAlertController(title: "Error", message:
                    "Please input first name, last name and age", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            
            if (profiles.indexOf({ $0.firstName == firstName && $0.lastName == lastName}) != nil) {
                let alertController = UIAlertController(title: "Error", message:
                    "\(firstName) \(lastName)'s profile already exists", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)

            }
            
            var profile: Profile!
            if isEdit == true {
                let index = profiles.indexOf({ $0.firstName == selectedProfile?.firstName && $0.lastName == selectedProfile?.lastName})
                profile = profiles[index!]
                isEdit = false
            } else {
                profile = Profile()
            }
            
            
            profile.firstName = firstName
            profile.lastName = lastName
            profile.age = age
            profile.pregnant = pregnant
            profile.allergen = allergen
            
            
            profiles.append(profile)
            
            let centerController = segue.destinationViewController as! CenterViewController
            centerController.profiles = self.profiles
            if selectedProfile == nil {
                centerController.selectedProfile = profile
            }

            
        }
    }
    
    
    
}
