//
//  MedicineDetailViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 2/14/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit


class MedicineDetailViewController: UIViewController {
    
    
    
    


    
    @IBOutlet var indicationTextView: UITextView!
    @IBOutlet var containdicationTextView: UITextView!
    @IBOutlet var dosageTextView: UITextView!
    @IBOutlet var sideEffectTextView: UITextView!


    @IBOutlet var image: UIImageView!
    
    var medicine: Medicine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        //self.navigationItem.title = medicine.name
        dosageTextView.text = medicine.dosage
        indicationTextView.text = medicine.indication
        containdicationTextView.text = medicine.contraindication
        sideEffectTextView.text = medicine.sideEffect
        image.image = UIImage(named: medicine.image!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        self.Scroller.frame = self.view.bounds
//        self.Scroller.contentSize.height = 1200
//        self.Scroller.contentSize.width = 0
//    }
  
}