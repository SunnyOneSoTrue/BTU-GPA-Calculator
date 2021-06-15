//
//  SemesterGPAViewController.swift
//  BTU GPU calculator
//
//  Created by USER on 31.05.21.
//

import UIKit

class SemesterGPAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var semesterOne = true // used to save the GPAs to the coresponding semester
    var semesterTwo = false // same here as there ^
    var calculateKey: Bool? = false // used to toggle when to calculate the gpas
    var subjectCount = 1 // used to generate the amount of subject a user has
    
    var recordedGPAs: [String:Any] = [:] // gpas the student has calculated in the page before
    var SubjectNames: [Any] = [] // subjects the student entered
    
    
    var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","w","z",
                   "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                   "ა","ბ","გ","დ","ე","ვ","ზ","თ","ი","კ","ლ","მ","ნ","ო","პ","ჟ","რ","ს","ტ","უ","ფ","ქ","ღ","ყ","შ","ჩ","ც","ძ","წ","ჭ","ხ","ჯ"
                   ,"ჰ","!","ძ","@","#","$","^","%","&","*","(",")","-","_","+","="] // used to determine if input has any letters in it
    
    var gpaTimesCreditSum = 0.0
    var aquiredCreditSum = 0.0
    
    
    var defaults = UserDefaults.standard

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var semesterGPALabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setRecordedGPAs()
        calculateKey = false
    }
    
    
    @IBAction func onCalculate(_ sender: UIButton) {
        calculateKey = true
        table.reloadData()
    }
    
    @IBAction func onEdit(_ sender: UIBarButtonItem) {
        table.isEditing = !table.isEditing
        if table.isEditing == true{
            editButton.title = "done"
        }
        else{
            editButton.title = "edit"
        }
    }
    
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            gpaTimesCreditSum = 0.0
            calculateKey=false
            setRecordedGPAs()
            semesterOne = false
            semesterTwo = true
            table.reloadData()
            semesterGPALabel.font = semesterGPALabel.font.withSize(28)
            semesterGPALabel.text = "სემესტრული GPA"
            
            
        default:
            gpaTimesCreditSum = 0.0
            calculateKey=false
            setRecordedGPAs()
            semesterOne = true
            semesterTwo = false
            table.reloadData()
            semesterGPALabel.font = semesterGPALabel.font.withSize(28)
            semesterGPALabel.text = "სემესტრული GPA"
        }
    }
    
    func calculateSemesterGPA(cell: SemesterTableViewCell, indexpath: IndexPath){
        if cell.subjectNameField?.text != "" && (cell.subjectCreditField?.text)! != "" && (cell.subjectGPAField?.text)! != "" && containsALetter(string: cell.subjectGPAField.text!) == false && containsALetter(string: cell.subjectCreditField.text!) == false {// if no name, gpa or credit is entered or the gpa or credit string contains a letter
            
            if Double((cell.subjectGPAField.text)!)! <= 4.0 && Double((cell.subjectGPAField?.text)!)! >= 0.0 && Int((cell.subjectCreditField?.text)!)! >= 3 && Int((cell.subjectCreditField?.text)!)! <= 6 { // it is impossible to get less than 0 and more than 4.0 as a gpa and less than 3 and more than 6 credit
                
                cell.subjectNameField!.layer.borderColor = CGColor(red: 1.00, green: 0.00, blue: 0.49, alpha: 1.00)
                cell.subjectGPAField!.layer.borderColor = CGColor(red: 0.03, green: 0.00, blue: 0.68, alpha: 1.00)
                cell.subjectCreditField!.layer.borderColor = CGColor(red: 1.00, green: 0.00, blue: 0.49, alpha: 1.00)
                
                gpaTimesCreditSum += Double(cell.subjectGPAField.text!)! * Double(cell.subjectCreditField.text!)!
                aquiredCreditSum += Double(Int(cell.subjectCreditField.text!)!)
                
                if indexpath.row == SubjectNames.count-1 {
                    let semesterGPA = round(gpaTimesCreditSum/aquiredCreditSum * 100) / 100.0
                    semesterGPALabel.font = semesterGPALabel.font.withSize(60)
                    semesterGPALabel.text = String(semesterGPA)
                    save(this: semesterGPA)
                }
            }
            else if Double(Int((cell.subjectGPAField.text)!)!) > 4.0 || Int((cell.subjectGPAField?.text)!)! < 0 {
                cell.subjectGPAField!.layer.borderWidth = 1
                cell.subjectGPAField!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
            else if Int((cell.subjectCreditField?.text)!)! < 3 && Int((cell.subjectCreditField?.text)!)! > 6 {
                cell.subjectCreditField!.layer.borderWidth = 1
                cell.subjectCreditField!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }
        else if (cell.subjectCreditField?.text)! == "" || containsALetter(string: cell.subjectCreditField.text!){
            cell.subjectCreditField!.layer.borderWidth = 1
            cell.subjectCreditField!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
        else if (cell.subjectGPAField?.text)! == "" || containsALetter(string: cell.subjectGPAField.text!){
            cell.subjectGPAField!.layer.borderWidth = 1
            cell.subjectGPAField!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
        else if cell.subjectNameField?.text == ""{
            cell.subjectNameField!.layer.borderWidth = 1
            cell.subjectNameField!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }

    
    func containsALetter(string:String)->Bool{
        for letter in string{
            if(letters.contains(String(letter))){return true}
            else {return false}
        }
        return true
    }
        
        func save(this semesterGPA:Double){
            if semesterOne{
                defaults.setValue(gpaTimesCreditSum, forKey: "semester1GPAsTimesCredits")
                defaults.setValue(semesterGPA, forKey: "semester1GPA")
            }
            else if semesterTwo{
                defaults.setValue(gpaTimesCreditSum, forKey: "semester2GPAsTimesCredits")
                defaults.setValue(semesterGPA, forKey: "semester2GPA")
            }
        }
    }
    
    func setRecordedGPAs(){
        if segments.selectedSegmentIndex == 0 && defaults.dictionary(forKey: "semester1GPAs") != nil {
            recordedGPAs = defaults.dictionary(forKey: "semester1GPAs")!
            SubjectNames = defaults.array(forKey: "semester1SubjectNames")!
        }
        else if segments.selectedSegmentIndex == 1 && defaults.dictionary(forKey: "semester2GPAs") != nil{
            recordedGPAs = defaults.dictionary(forKey: "semester2GPAs")!
            SubjectNames = defaults.array(forKey: "semester2SubjectNames")!
        }
        subjectCount = SubjectNames.count
        table.reloadData()
    }
}


//MARK: tableview stuff
extension SemesterGPAViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if defaults.array(forKey: "semester1SubjectNames") != nil || defaults.array(forKey: "semester2SubjectNames") != nil{
            return SubjectNames.count
        }
        else {
            return subjectCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SemesterTableViewCell", for: indexPath) as! SemesterTableViewCell
        
        if segments.selectedSegmentIndex == 0 && defaults.dictionary(forKey: "semester1GPAs") != nil {
            cell.subjectGPAField.text = "\(String(describing: recordedGPAs["\(SubjectNames[indexPath.row])"]!))"
            cell.subjectNameField.text = SubjectNames[indexPath.row] as? String
        }
        else if segments.selectedSegmentIndex == 1 && defaults.dictionary(forKey: "semester2GPAs") != nil{
            cell.subjectGPAField.text = "\(String(describing: recordedGPAs["\(SubjectNames[indexPath.row])"]!))"
            cell.subjectNameField.text = SubjectNames[indexPath.row] as? String
        }
        
        
        
        if(calculateKey!){
            calculateSemesterGPA(cell: cell, indexpath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            table.beginUpdates()
            
            subjectCount -= 1
            table.deleteRows(at: [indexPath], with: .left)
            recordedGPAs.removeValue(forKey: "\(SubjectNames[indexPath.row])")
            SubjectNames.remove(at: indexPath.row)
            
            table.endUpdates()
        }
    }
}

