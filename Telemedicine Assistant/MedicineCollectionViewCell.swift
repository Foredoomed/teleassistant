//
//  MedicineCollectionViewCell.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 3/2/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class MedicineCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet var medicineImageView: UIImageView!
    @IBOutlet var medicineNameLabel: UILabel!
   
    
    var medicine: Medicine? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        medicineImageView.image = UIImage(named: (medicine?.image)!)
        medicineNameLabel.text = medicine?.name
    }
}
