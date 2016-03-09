//
//  ReminderCollectionViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 3/2/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class ReminderCollectionViewController: UICollectionViewController {
    
    var medicines = [Medicine]()
    var hours: Int = 0
    
    let leftAndRightPadding: CGFloat = 10.0
    let numberOfItemPerRow: CGFloat = 3.0
    //let heightAdjustment: CGFloat = 30.0

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        prepareMedicines()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func prepareMedicines(){
        prepareMedicine("Tylenol",image: "tylenol.jpg")
        prepareMedicine("Bufferin",image: "Bufferin.jpeg")
        prepareMedicine("Aspirin", image: "Aspirin.jpg")
        prepareMedicine("Ibuprofen Suspension", image: "Ibuprofen Suspension.gif")
        prepareMedicine("Analgin", image: "Analgin.jpg")
        
        prepareMedicine("Contac NT", image: "Contac NT.jpg")
        prepareMedicine("Avelox",  image: "Buckley.jpg")
        prepareMedicine("Buckley", image: "Buckley.jpg")
        prepareMedicine("Mucosolvan",image: "Mucosolvan.jpg")
        prepareMedicine("Sudafed PE", image: "Sudafed PE.jpg")
        
        prepareMedicine("Imodium", image: "Imodium.jpg")
        prepareMedicine("Peptobismol", image: "Peptobismol.jpg")
        prepareMedicine("Smecta", image: "Smecta.jpg")
        prepareMedicine("Dulcolax", image: "Dulcolax.png")
        prepareMedicine("Dicetel",  image: "Dicetel.jpg")
        
        prepareMedicine("Zantac", image: "Zantac.jpg")
        prepareMedicine("Prevacid", image: "Prevacid.jpg")
        prepareMedicine("Motilium", image: "Motilium.jpg")
        prepareMedicine("Prilosec", image: "Prilosec.GIF")
        prepareMedicine("Zegerid", image: "Zegerid.jpg")
        
        prepareMedicine("Cortizone 10", image: "Cortizone 10.jpg")
        prepareMedicine("Benadryl",  image: "Benadryl.jpg")
        prepareMedicine("Neosporin", image: "Neosporin.jpg")
        prepareMedicine("Lotrimin", image: "Lotrimin.jpg")
        prepareMedicine("Clarityne", image: "CLARITYNE.jpg")
    }
    
    func prepareMedicine(name: String, image: String){
        let medicine = Medicine()
        medicine.name = name
        medicine.image = image
        
        medicines.append(medicine)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicines.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("medicineCollectionCell", forIndexPath: indexPath) as! MedicineCollectionViewCell
        cell.medicine = medicines[indexPath.row]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.greenColor().CGColor
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    
    @IBAction func startAlarm(sender: AnyObject) {
        hours = Int(arc4random_uniform(7)) + 6
        let alertController = UIAlertController(title: "Reminder", message:
            "You will be remindered after \(hours) hours", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        ceateNotification()
    }
    
    func ceateNotification(){
        
        let date = NSDate()
        let dateComponents = NSDateComponents()
        //dateComponents.hour = hours
        dateComponents.second = 10
        let calendar = NSCalendar.currentCalendar()
        let fireDate = calendar.dateByAddingComponents(dateComponents, toDate: date, options: [])
        
        let localNotification = UILocalNotification()
        localNotification.alertBody = "It's time to have some medicine"
                localNotification.fireDate = fireDate

        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
}
