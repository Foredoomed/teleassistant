//
//  CenterViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 2/27/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    var selectedProfile: Profile?
    var profiles = [Profile]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showProfile" {
            let profileTableViewController = segue.destinationViewController as! ProfileTableViewController
            profileTableViewController.profiles = profiles
            profileTableViewController.selectedProfile = self.selectedProfile
        }
        
        if segue.identifier == "adviserSegueIndentifier" {
            let adviserViewController = segue.destinationViewController as! AdviserViewController
            adviserViewController.profile = selectedProfile
        }
    }


}
