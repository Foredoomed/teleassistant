//
//  AdviserViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 2/28/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit

class AdviserViewController: UIViewController {

    @IBOutlet var symptomTextField: UITextField!
    
    var profile: Profile?
    var medicines: [Medicine] = []
    var prescription: [Medicine] = []
    let fever = "cold,fever,antipyretic"
    let cough = "Upper Respiratory tract infections"
    let diarrhea = "diarrhea,antidiarrheic"
    let stomache = "stomach ache,stomach-ache"
    let allergy = "allergy,antiallergic"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        prepareMedicines()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPrescription" {
            prescription.removeAll()
            let symptom = symptomTextField.text!
            if !symptom.isEmpty {
                for medicine in medicines {
                    if medicine.keyWord?.rangeOfString(symptom.lowercaseString) != nil {
                        let medicineAllergen:[String] = (medicine.allergen?.lowercaseString.characters.split(",").map(String.init))!
                        let peopleAllergen:[String] = (profile!.allergen?.lowercaseString.characters.split(",").map(String.init))!
                        var isNotAllergery: Bool! = true
                        for x in medicineAllergen {
                            for y in peopleAllergen {
                                if x.rangeOfString(y) != nil {
                                    isNotAllergery = false
                                }
                            }
                        }
                        
                        var forPregnant: Bool! = false
                        let people = medicine.forCategoryOfPeople?.lowercaseString
                        if profile?.pregnant == true {
                            if people?.rangeOfString("pregnant") != nil {
                                forPregnant = true
                            }
                        }
                        
                        var forChild: Bool! = false
                        let isChild: Bool = profile?.age > 1 && profile!.age < 18
                        if isChild {
                            if people?.rangeOfString("child") != nil {
                                forChild = true
                            }
                        }
                        
                        if isNotAllergery == false && (profile?.pregnant == false || forPregnant == true) && (isChild == false || forChild == true)  {
                            prescription.append(medicine)
                        }
                        
                    }
                }
            }
            let tableViewController = segue.destinationViewController as! PrescriptionTableViewController
            tableViewController.prescription = prescription
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func prepareMedicine(name: String,contraindication: String, dosage: String, image: String, keyWord: String, sideEffect: String, indication: String, allergen: String, forCategoryOfPeople: String){
        let medicine = Medicine()
        medicine.name = name
        medicine.contraindication = contraindication
        medicine.dosage = dosage
        medicine.image = image
        medicine.keyWord = keyWord
        medicine.sideEffect = sideEffect
        medicine.indication = indication
        medicine.allergen = allergen
        medicine.forCategoryOfPeople = forCategoryOfPeople
        medicines.append(medicine)
    }
    
    func prepareMedicines(){
        prepareMedicine("Tylenol", contraindication: "Acute Liver Failure, Liver Problems, Serious Kidney Problems, Shock, Overdose of the Drug Acetaminophen, Poor Nutrition", dosage: "Adult: 1-2 pills; child: 1 pill", image: "tylenol.jpg", keyWord: fever, sideEffect: "Nausea, upper stomach pain, itching, loss of appetite; dark urine, clay-colored stools; jaundice (yellowing of the skin or eyes)", indication: "Treating minor aches and pains due to headache, muscle aches, backache, arthritis, the common cold, flu, toothache, menstrual cramps, and immunizations, and for temporarily reducing fever.", allergen: "Ibuprofen,Amidopyrine", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Bufferin", contraindication: "Reye's Syndrome, Tumor that Dissolves Bone, Thrombotic Thrombocytopenic Purpura, Presence of Polyps in the Nose, Ulcer from Stomach Acid, Stomach or Intestinal Ulcer", dosage: "Adult: 0.25-0.5g; 11 years old:480mg; 9-10 years old: 400mg; 6-8 years old: 320mg; 4-5 years old: 240mg; 2-3 years old: 160mg", image: "Bufferin.jpeg", keyWord: fever, sideEffect: "Tell your doctor right away if any of these unlikely but serious side effects occur: easy bruising/bleeding, difficulty hearing, ringing in the ears, change in the amount of urine, persistent or severenausea/vomiting, unexplained tiredness, dizziness, dark urine, yellowing eyes/skin.", indication: "For use in the temporary relief of various forms of pain, inflammation associated with various conditions (including rheumatoid arthritis, juvenile rheumatoid arthritis, systemic lupus erythematosus, osteoarthritis, and ankylosing spondylitis), and is also used to reduce the risk of death and/or nonfatal myocardial infarction in patients with a previous infarction or unstable angina pectoris.", allergen: "Ibuprofen,Amidopyrine",forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Aspirin", contraindication: "Reye's Syndrome, Thrombotic Thrombocytopenic Purpura, Presence of Polyps in the Nose, Ulcer from Stomach Acid, Stomach or Intestinal Ulcer, Damage to Stomach Lining, Liver Problems, Bleeding of the Stomach or Intestines", dosage: "Adult: 0.3-0.6g; child: 5-10mg", image: "Aspirin.jpg", keyWord: fever, sideEffect: "Common side effects of Bayer Aspirin include rash, gastrointestinal ulcerations, abdominal pain, upset stomach, heartburn, drowsiness, headache, cramping, nausea, gastritis, and bleeding. Bayer Aspirin dose ranges from 50 mg to 6000 mg daily.", indication: "Treating minor aches and pains (eg, caused by headache, muscle aches, backache, arthritis, the common cold, toothache, menstrual cramps). It is used in certain patients to decrease the risk of stroke, heart attack, and death associated with stroke or heart attack. It may also be used for other conditions as determined by your doctor.", allergen: "Ibuprofen,Amidopyrine,Paracetamol",forCategoryOfPeople: "")
        prepareMedicine("Ibuprofen Suspension", contraindication: "NSAIDs cause an increased risk of serious gastrointestinal adverse events including bleeding, ulceration, and perforation of the stomach or intestines, which can be fatal. These events can occur at any time during use and without warning symptoms. Elderly patients are at greater risk for serious gastrointestinal events", dosage: "Adult: 20ml; 1-3 years old: 4ml; 4-6 years old: 5ml; 7-9 years old: 8ml; 10-12 years old:10ml", image: "Ibuprofen Suspension.gif", keyWord: fever, sideEffect: "Upset stomach, nausea, vomiting, headache, diarrhea, constipation, dizziness, or drowsiness may occur. If any of these effects persist or worsen, tell your doctor or pharmacist promptly. If your doctor has directed you to use this medication, remember that he or she has judged that the benefit to you is greater than the risk of side effects. Many people using this medication do not have serious side effects. This medication may raise your blood pressure. Check your blood pressure regularly and tell your doctor if the results are high.", indication: "Treating minor aches and pains caused by the common cold, flu, sore throat, headaches, or toothaches. It may be used to reduce fever. It may also be used for other conditions as determined by your doctor.", allergen: "Amidopyrine,Paracetamol", forCategoryOfPeople: "child")
        prepareMedicine("Analgin", contraindication: "Hypersensitivity to metamizole and other pyrazolone derivatives, acute hepatic porphyria, inborn glucose-6-phosphate dehydrogenase deficiency, severe renal or hepatic diseases, blood diseases (such as aplastic anemia, leucopenia and agranulocytosis), pregnancy (the first and the last trimester). Parenteral administration of Analgin is contraindicated in under 1 year-old children.", dosage: "250-500mg once a day", image: "Analgin.jpg", keyWord: fever, sideEffect: "From the hematopoietic system - thrombocytopenia, leukopenia, agranulocytosis; on the part of the excretory system - functional disorders of the kidneys, proteinuria, anuria, oliguria; of the cardiovascular system - lowering blood pressure; allergic reactions - urticaria, angioedema , malignant exudative erythema, bronchospasm, anaphylactic shock; local reactions at intramuscular injections - infiltrates in the administration of the solution", indication: "Treatment of pains of different origin and variable intensity: toothache, headache, arthralgia, neuralgia, myositis, mild to moderate visceral pain, high fever, not responding to other drugs. Analgin injection is used in cases of acute and severe pain after operations and traumas, pain associated with neoplastic diseases, colicky pain etc.", allergen: "Ibuprofen,Paracetamol",forCategoryOfPeople: "")
        
        prepareMedicine("Contac NT", contraindication: "Contraindicated in patients with severe high blood pressure, children less than 12 years and hypersensitivity.", dosage: "1 tablet every 12 hours", image: "Contac NT.jpg", keyWord: cough, sideEffect: "Constipation; diarrhea; dizziness; drowsiness; excitability; headache; loss of appetite; nausea; nervousness or anxiety; trouble sleeping; upset stomach; vomiting; weakness.", indication: "reduces the effects of natural chemical histamine in the body. Histamine can produce symptoms of sneezing, itching, watery eyes, and runny nose.",allergen: "Ambroxol hydrochloride,Compound Pseudoephedrine Hydrochloride,Moxifloxacin,Pseudoephedrine,Liver and kidney dysfunction",forCategoryOfPeople: "child")
        prepareMedicine("Avelox", contraindication: "Lung Transplant, Epileptic Seizure, Lower Seizure Threshold, Pseudotumor Cerebri, Numbness, Tingling or Pain of Hands or Feet, Myasthenia Gravis, Detachment of the Retina of the Eye, Heart Transplant, Disease of Inadequate Blood Flow to the Heart Muscle.", dosage: "400mg every 24 hours", image: "Buckley.jpg", keyWord: cough, sideEffect: "Severe dizziness, fainting, fast or pounding heartbeats; sudden pain, snapping or popping sound, bruising, swelling, tenderness, stiffness, or loss of movement in any of your joints; diarrhea that is watery or bloody.", indication: "Treatment of the following bacterial infections in patients of 18 years and older caused by bacteria susceptible to moxifloxacin.", allergen: "Ambroxol hydrochloride,Compound Pseudoephedrine Hydrochloride,Pseudoephedrine,Chlorphenamine,hypertension",forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Buckley", contraindication: "Condition of Increased Mast Cells", dosage: "2 caplets every 4-6 hours. Do not exceed 8 caplets per day.", image: "Buckley.jpg", keyWord: cough, sideEffect: "Rash, itching/swelling (especially of the face/tongue/throat), severe dizziness, trouble breathing. List Buckley's Cough Mixture side effects by likelihood and severity.", indication: "Cough", allergen: "Ambroxol hydrochloride,Moxifloxacin,Pseudoephedrine,Chlorphenamine,hypertension",forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Mucosolvan", contraindication: "There are no absolute contraindications but in patients with gastric ulceration relative caution should be observed.", dosage: "1-2 tablets every 8 hours", image: "Mucosolvan.jpg", keyWord: cough, sideEffect: "Mucosolvan include stomach upset,nausea, vomiting, and diarrhea.", indication: "All forms of tracheobronchitis, emphysema with bronchitis pneumoconiosis, chronic inflammatory pulmonary conditions, bronchiectasis, bronchitis with bronchospasm asthma. During acute exacerbations of bronchitis it should be given with the appropriate antibiotic.",allergen: "Compound Pseudoephedrine Hydrochloride,Moxifloxacin,Pseudoephedrine,Chlorphenamine,Liver and kidney dysfunction,hypertension",forCategoryOfPeople: "child")
        prepareMedicine("Sudafed PE", contraindication: "Increased Pressure in the Eye, Closed Angle Glaucoma, Chronic Difficulty having a Bowel Movement, High Blood Pressure, Severe Uncontrolled High Blood Pressure, Heart Attack, Disease of the Arteries of the Heart, Partial Heart Block, Rapid Ventricular Heartbeat.", dosage: "1 tablet every 4 hours", image: "Sudafed PE.jpg", keyWord: cough, sideEffect: "Dizziness; headache; nausea; nervousness;restlessness; sleeplessness; stomach irritation.", indication: "Relieving congestion due to colds, flu, hay fever, and other allergies. It may also be used for other conditions as determined by your doctor.", allergen: "Compound Pseudoephedrine Hydrochloride,Moxifloxacin,Chlorphenamine,Liver and kidney dysfunction",forCategoryOfPeople: "child,pregnant")
        
        prepareMedicine("Imodium", contraindication: "Paralysis of the Intestines, Liver Problems, Infectious Diarrhea, Bloody Diarrhea.", dosage: "Adults: 4mg; 2-5 years old: 1mg; 6-8 years old: 2mg; 8-12 years old: 3mg", image: "Imodium.jpg", keyWord: diarrhea, sideEffect: "Dizziness, Drowsiness, Dry mouth, Vomiting, Constipation, Fatigue, Stomach pain, discomfort, or enlargement.", indication: "Treating symptoms of certain types of diarrhea. It is also used to decrease the amount of discharge from an ileostomy. It may also be used for to treat other conditions as determined by your doctor.",allergen: "bismuth salicylate,Pinaverium bromide,Bisacodyl", forCategoryOfPeople: "Child")
        prepareMedicine("Peptobismol", contraindication: "Kidney Disease, A Mother who is Producing Milk and Breastfeeding, Diabetes, Gout, Blood Clotting Disorder.", dosage: "Adults and children under 12: 30ml every 12 hours", image: "Peptobismol.jpg", keyWord: diarrhea, sideEffect: "Constipation; diarrhea; dizziness; drowsiness; excitability; headache; loss of appetite; nausea; nervousness or anxiety; trouble sleeping; upset stomach; vomiting; weakness.", indication: "Treating heartburn, upset stomach, indigestion, nausea, diarrhea, or symptoms associated with eating or drinking too much. It may be used to decrease the number of bowel movements and make the stool firmer. It may also be used to treat other conditions as determined by your doctor.",allergen: "Loperamide,Pinaverium bromide,Bisacodyl", forCategoryOfPeople: "Child")
        prepareMedicine("Smecta", contraindication: "Fructose intolerance, glucose & galactose malabsorption syndrome or sucrase/somaltase deficiency.", dosage: "20mg every 12 hours", image: "Smecta.jpg", keyWord: diarrhea, sideEffect: "Constipation; diarrhea; dizziness; drowsiness; excitability; headache; loss of appetite; nausea; nervousness or anxiety; trouble sleeping; upset stomach; vomiting; weakness.", indication: "Treatment of diarrhea and of painful symptoms associated with oesophageal-gastric and intestinal diseases.",allergen: "Loperamide,bismuth salicylate,Pinaverium bromide,Bisacodyl", forCategoryOfPeople: "Child,pregnant")
        prepareMedicine("Dulcolax", contraindication: "Appendicitis, Stomach or Intestine Blockage, Unable to Control Bowel Movement.", dosage: "Adults and children over 10 years old: One or two tablets at night; Children 6-10 years old: One tablet at night.", image: "Dulcolax.png", keyWord: diarrhea, sideEffect: "Dizziness, weakness, increased thirst; mild stomach pain, gas, indigestion; diarrhea or loose stools; mild nausea, skin rash.", indication: "Relieving occasional constipation and irregularity. It may also be used for other conditions as determined by your doctor.",allergen: "Loperamide,bismuth salicylate,Pinaverium bromide", forCategoryOfPeople: "")
        prepareMedicine("Dicetel", contraindication: "CYP2C19 Poor Metabolizer, Liver Problems, Interstitial Nephritis, Clostridium Difficile Bacteria Related Colitis, Osteoporosis, Broken Bone, Inadequate Vitamin B12, Low Amount of Magnesium in the Blood.", dosage: "50mg every 12 hours", image: "Dicetel.jpg", keyWord: diarrhea, sideEffect: "Abdominal bloating, dry mouth, feeling of fullness, heartburn, nausea, skin allergy.", indication: "Relieve the symptoms of abdominal pain, bowel disturbances, and intestinal discomfort.",allergen: "Loperamide,bismuth salicylate,Bisacodyl", forCategoryOfPeople: "")
        
        prepareMedicine("Zantac", contraindication: "Liver Problems, Kidney Disease, Stomach Cancer, Porphyria.", dosage: "50 mL/min is 150 mg or 10 mL of syrup (2 teaspoonfuls of syrup equivalent to 150 mg of ranitidine) every 24 hours", image: "Zantac.jpg", keyWord: stomache, sideEffect: "Severe dizziness, fainting, fast or pounding heartbeats; sudden pain, snapping or popping sound, bruising, swelling, tenderness, stiffness, or loss of movement in any of your joints; diarrhea that is watery or bloody.", indication: "Treating certain conditions that cause your body to make too much stomach acid (eg, Zollinger-Ellison syndrome). It is also used to treat ulcers of the small intestine that have not responded to other treatment. It may be used as a short-term alternative to oral ranitidine, in patients who are not able to take medicine by mouth. It may also be used for other conditions as determined by your doctor.",allergen: "Lansoparazole,Domperidone,sodium bicarbonate,Omeprazole Magnesium", forCategoryOfPeople: "child")
        prepareMedicine("Prevacid", contraindication: "CYP2C19 Poor Metabolizer, Severe Liver Disease, Interstitial Nephritis, Clostridium Difficile Bacteria Related Colitis, Osteoporosis, Broken Bone, Inadequate Vitamin B12, Low Amount of Magnesium in the Blood.", dosage: "30mg every 12 hours", image: "Prevacid.jpg", keyWord: stomache, sideEffect: "Severe dizziness, fainting, fast or pounding heartbeats; sudden pain, snapping or popping sound, bruising, swelling, tenderness, stiffness, or loss of movement in any of your joints; diarrhea that is watery or bloody.", indication: "Allergic, intolerant, or resistant to clarithromycin) for H. pylori eradication in duodenal ulcer disease.",allergen: "Acute porphyria disease,Domperidone,RANITIDINE HYDROCHLORIDE,sodium bicarbonate,Omeprazole Magnesium", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Motilium", contraindication: "Very Rapid Heartbeat - Torsades de Pointes, Prolonged Q-T Interval on EKG, Heart Failure, Abnormal EKG with QT changes from Birth, Stomach or Intestine Blockage, Liver Problems.", dosage: "One tablet three times a day.", image: "Motilium.jpg", keyWord: stomache, sideEffect: "Severe dizziness, fainting, fast or pounding heartbeats; sudden pain, snapping or popping sound, bruising, swelling, tenderness, stiffness, or loss of movement in any of your joints; diarrhea that is watery or bloody.", indication: "Relief of the symptoms of nausea and vomiting.",allergen: "Acute porphyria disease,Lansoparazole,RANITIDINE HYDROCHLORIDE,sodium bicarbonate,Omeprazole Magnesium", forCategoryOfPeople: "")
        prepareMedicine("Prilosec", contraindication: "Atrophic Gastritis, CYP2C19 Poor Metabolizer, Liver Problems, Interstitial Nephritis, Clostridium Difficile Bacteria Related Colitis, Osteoporosis, Broken Bone, Inadequate Vitamin B12, Low Amount of Magnesium in the Blood.", dosage: "20mg once a day.", image: "Prilosec.GIF", keyWord: stomache, sideEffect: "Fever, cold symptoms such as stuffy nose, sneezing, sore throat, stomach pain, gas, nausea, vomiting, mild diarrhea, nausea, vomiting, mild diarrhea.", indication: "Short-term treatment of active duodenal ulcer in adults.",allergen: "Acute porphyria disease,Lansoparazole,Domperidone,RANITIDINE HYDROCHLORIDE,sodium bicarbonate", forCategoryOfPeople: "pregnant")
        prepareMedicine("Zegerid", contraindication: "Atrophic Gastritis, CYP2C19 Poor Metabolizer, Chronic Heart Failure, Liver Problems, Interstitial Nephritis, Serious Kidney Problems, Clostridium Difficile Bacteria Related Colitis, Osteoporosis, Visible Water Retention, Kidney Problems Causing a Decreased Amount of Urine to be Passed, Broken Bone, Inadequate Vitamin B12, Low Amount of Magnesium in the Blood.", dosage: "20mg every 12 hours", image: "Zegerid.jpg", keyWord: stomache, sideEffect: "Low magnesium blood level (such as unusually fast/slow/irregular heartbeat, persistent muscle spasms, seizures), sudden weight gain.", indication: "Short‑term treatment of active duodenal ulcer.",allergen: "Acute porphyria disease,Lansoparazole,Domperidone,RANITIDINE HYDROCHLORIDE", forCategoryOfPeople: "pregnant")
        
        prepareMedicine("Cortizone 10", contraindication: "Insufficiency of the Hypothalamus and Pituitary Gland.", dosage: "This medication can be applied up to 3 times each day.", image: "Cortizone 10.jpg", keyWord: allergy, sideEffect: "Inflammation of a hair follicleSevere, large purple or brown skin blotches, skin infection, thin fragile skin.", indication: "Reducing itching, redness, and swelling associated with many skin conditions.",allergen: "Diphenhydramine,Neosporin,Clotrimazole,Loratadine", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Benadryl", contraindication: "Increased Pressure in the Eye, Closed Angle Glaucoma, Chronic Difficulty having a Bowel Movement, High Blood Pressure, Stenosing Peptic Ulcer, Blockage of Urinary Bladder, Enlarged Prostate, Cannot Empty Bladder, Overactive Thyroid Gland.", dosage: "Adults and children 12 years old and over: 25mg to 50mg (1 to 2 capsules); children 6 to under 12 years old: 12.5mg to 25mg (1 capsule).", image: "Benadryl.jpg", keyWord: allergy, sideEffect: "Drowsiness, dizziness, constipation, stomach upset, blurred vision, ordry mouth/nose/throat may occur.", indication: "Symptoms of upper respiratory allergies. Rhinorrhea/sneezing due to common cold.",allergen: "Hydrocortisone,Neosporin,Clotrimazole,Loratadine", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Neosporin", contraindication: "Large Open Wound, Severe Burn.", dosage: "This medication can be applied up to 3 times each day.", image: "Neosporin.jpg", keyWord: allergy, sideEffect: "Severe allergic reactions (rash; hives; itching; difficulty breathing; tightness in the chest; swelling of the mouth, face, lips, or tongue); skin irritation, pain, burning, cracking, redness, or peeling not present before using Neosporin ointment; worsening or recurrence of wound symptoms.", indication: "Treating and preventing infection due to minor cuts, scrapes, and burns.",allergen: "Hydrocortisone,Diphenhydramine,Clotrimazole,Loratadine", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Lotrimin", contraindication: "Unexplained Abdominal Pain", dosage: "50mg every 12 hours", image: "Lotrimin.jpg", keyWord: allergy, sideEffect: "Burning, stinging, swelling, irritation, redness, pimple-like bumps, tenderness, or flaking of the treated skin may occur.", indication: "Treating athlete's foot, jock itch, and ringworm. It may also be used for other conditions as determined by your doctor.",allergen: "Hydrocortisone,Diphenhydramine,Neosporin,Loratadine", forCategoryOfPeople: "child,pregnant")
        prepareMedicine("Clarityne", contraindication: "Liver Failure, Liver Problems, Moderate to Severe Kidney Impairment.", dosage: "6 years old or older: 10mg orally once a day (tablets, capsule, and disintegrating tablets); 2-5 years old: 5mg orally once a day.", image: "CLARITYNE.jpg", keyWord: allergy, sideEffect: "Headache, nervousness, feeling tired or drowsy, stomach pain, diarrhe, dry mouth, sore throat hoarseness, eye redness, blurred vision,nosebleed; or skin rash.", indication: "reduces the effects of natural chemical histamine in the body.",allergen: "Hydrocortisone,Diphenhydramine,Neosporin,Clotrimazole", forCategoryOfPeople: "child")
    }

}
