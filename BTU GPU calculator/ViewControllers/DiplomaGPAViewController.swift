//
//  DiplomaGPAViewController.swift
//  BTU GPU calculator
//
//  Created by USER on 14.06.21.
//

import UIKit

class DiplomaGPAViewController: UIViewController {
    @IBOutlet weak var gpaLabel: UILabel!
    
    var defaults = UserDefaults.standard
    
    var year1GpaTimesCreditSum = -1.0
    var year2GpaTimesCreditSum = -1.0
    var year3GpaTimesCreditSum = -1.0
    var year4GpaTimesCreditSum = -1.0
    
    
    var year1CreditSum = -1
    var year2CreditSum = -1
    var year3CreditSum = -1
    var year4CreditSum = -1
    
    var gpaTimesCreditSum = 0.0
    var CreditSum = 0
    var yearlyGPA = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setGpaStuff()
    }
    
    @IBAction func onCalculate(_ sender: Any) {
        
        let gpa = 4.0
        gpaLabel.textColor = .black
        gpaLabel.text = String(gpa)
        
        
//        var gpa = (year1GpaTimesCreditSum + year2GpaTimesCreditSum + year4GpaTimesCreditSum + year4GpaTimesCreditSum) / Double(year1CreditSum + year2CreditSum + year3CreditSum + year4CreditSum)
//
//        var condition1 = year1GpaTimesCreditSum > 0.0 && year2GpaTimesCreditSum>0.0 && year3GpaTimesCreditSum > 0.0  && year4GpaTimesCreditSum > 0.0
//
//        var condition2 = year1CreditSum > 0 && year2CreditSum > 0 && year3CreditSum > 0 && year4CreditSum > 0
//
//        if condition1 && condition2 {
//            gpaLabel.font = gpaLabel.font.withSize(56)
//            gpaLabel.text = String(gpa)
//        }
//        else{
//            gpaLabel.layer.borderColor = UIColor.red.cgColor
//            gpaLabel.layer.borderWidth = 3.0
//        }
    }
    
    func setGpaStuff(){
        if defaults.double(forKey: "year1SubjectGPATimesCreditSum") != nil && defaults.double(forKey: "year1CreditsSum") != nil{
            year1GpaTimesCreditSum = defaults.double(forKey: "year1SubjectGPATimesCreditSum")
            year1CreditSum = defaults.integer(forKey: "year1CreditsSum")
        }
        else if defaults.double(forKey: "year2SubjectGPATimesCreditSum") != nil && defaults.double(forKey: "year2CreditsSum") != nil{
            year2GpaTimesCreditSum = defaults.double(forKey: "year2SubjectGPATimesCreditSum")
            year2CreditSum = defaults.integer(forKey: "year2CreditsSum")
        }
        else if defaults.double(forKey: "year3SubjectGPATimesCreditSum") != nil && defaults.double(forKey: "year3CreditsSum") != nil{
            year2GpaTimesCreditSum = defaults.double(forKey: "year2SubjectGPATimesCreditSum")
            year2CreditSum = defaults.integer(forKey: "year2CreditsSum")
        }
        else if defaults.double(forKey: "year4SubjectGPATimesCreditSum") != nil && defaults.double(forKey: "year4CreditsSum") != nil{
            year2GpaTimesCreditSum = defaults.double(forKey: "year4SubjectGPATimesCreditSum")
            year2CreditSum = defaults.integer(forKey: "year4CreditsSum")
        }
    }
    
}
