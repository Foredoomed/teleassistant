//
//  PrescriptionTableViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 2/14/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class PrescriptionTableViewController: UITableViewController {
    
    var prescription:[Medicine]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        self.navigationItem.title = "Prescription"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescription.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prescriptionCell", forIndexPath: indexPath)
        cell.textLabel?.text = prescription[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let destination = segue.destinationViewController as? MedicineDetailViewController {
                if let index = tableView.indexPathForSelectedRow?.row {
                    destination.medicine = prescription[index]
                }
            }
        }
    }



    
}