//
//  ProfileTableViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 3/3/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var selectedProfile: Profile!
    var profiles = [Profile]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profiles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profileIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = profiles[indexPath.row].firstName + " " + profiles[indexPath.row].lastName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let profile = profiles[indexPath.row]
        performSegueWithIdentifier("showEditProfile", sender: profile)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditProfile" {
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.selectedProfile = (sender as! Profile)
            profileViewController.profiles = self.profiles
            profileViewController.isEdit = true
        }
        
        if segue.identifier == "didSelectProfile" {
            let centerViewController = segue.destinationViewController as! CenterViewController
            centerViewController.selectedProfile = (sender as! Profile)
            centerViewController.profiles = self.profiles
        }
        
        if segue.identifier == "showAddProfile" {
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.selectedProfile = self.selectedProfile
            profileViewController.profiles = self.profiles
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        let profile = profiles[indexPath.row]
//        performSegueWithIdentifier("didSelectProfile", sender: profile)
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let selectAction = UITableViewRowAction(style: .Normal, title: "Select") { (action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
            let activityItem = self.profiles[indexPath.row]
            //let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
            self.performSegueWithIdentifier("didSelectProfile", sender: activityItem)
        }
        
        selectAction.backgroundColor = UIColor.blueColor()
        return [selectAction]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
