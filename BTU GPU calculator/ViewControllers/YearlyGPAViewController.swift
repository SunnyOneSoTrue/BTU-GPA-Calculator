//
//  YearlyGPAViewController.swift
//  BTU GPU calculator
//
//  Created by USER on 13.06.21.
//

import UIKit

class YearlyGPAViewController: UIViewController {

    @IBOutlet weak var CreditsSumField: UITextField!
    @IBOutlet weak var YearlyGPALabel: UILabel!
    @IBOutlet weak var yearlySegment: UISegmentedControl!
    
    var defaults = UserDefaults.standard
    
    var GPASum = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setRecordedGPAs()
    }
    
    @IBAction func onCalculate(_ sender: UIButton) {
        
        YearlyGPALabel.text = "\(round(GPASum/Double(CreditsSumField.text!)! * 100) / 100.0)"
        
        switch yearlySegment.selectedSegmentIndex {
        case 1:
            defaults.setValue(GPASum, forKey: "year2SubjectGPATimesCreditSum")
            defaults.setValue(Int(CreditsSumField.text ?? "0"), forKey: "year2CreditsSum")
        case 2:
            defaults.setValue(GPASum, forKey: "year3SubjectGPATimesCreditSum")
            defaults.setValue(Int(CreditsSumField.text ?? "0"), forKey: "year3CreditsSum")
        case 3:
            defaults.setValue(GPASum, forKey: "year4SubjectGPATimesCreditSum")
            defaults.setValue(Int(CreditsSumField.text ?? "0"), forKey: "year4CreditsSum")
        default:
            defaults.setValue(GPASum, forKey: "year1SubjectGPATimesCreditSum")
            defaults.setValue(Int(CreditsSumField.text ?? "0"), forKey: "year1CreditsSum")
        }
    }
    
    func setRecordedGPAs(){
        if(defaults.double(forKey: "semester1GPAsTimesCredits") != nil && (defaults.double(forKey: "semester2GPAsTimesCredits") != nil)){
            
            GPASum += defaults.double(forKey: "semester1GPAsTimesCredits")
            GPASum += defaults.double(forKey: "semester2GPAsTimesCredits")
        }
        else {
            YearlyGPALabel.font = YearlyGPALabel.font.withSize(20)
            YearlyGPALabel.text = "გთხოვთ ჯერ საგნების GPAები და აღებული კრედიტები დააფიქსიროთ სემესტრულ GPA კალკულატორში"
        }
    }
    
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        GPASum = 0.0
    }
    
}
