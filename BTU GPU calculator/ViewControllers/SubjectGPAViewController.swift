//
//  SubjectGPAViewController.swift
//  BTU GPU calculator
//
//  Created by USER on 20.05.21.
//

import UIKit

class SubjectGPAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var semesterOne = true// used to save the GPAs to the coresponding semester
    var semesterTwo = false// same here as there ^
    var calculateKey: Bool? // used to toggle when to calculate the gpas
    var subjectCount = 1 // used to generate the amount of subject a user has
    var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","w","z",
                   "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                   "ა","ბ","გ","დ","ე","ვ","ზ","თ","ი","კ","ლ","მ","ნ","ო","პ","ჟ","რ","ს","ტ","უ","ფ","ქ","ღ","ყ","შ","ჩ","ც","ძ","წ","ჭ","ხ","ჯ"
                   ,"ჰ","!","ძ","@","#","$","^","%","&","*","(",")","-","_","+","="] // used to determine if input has any letters in it
    
    //things I'll need in the next viewController
    var recordedGPAs: [String:Double] = [:]
    var recordedSubjecNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        calculateKey = false
    }
    
    @IBAction func onCalculate(_ sender: UIButton) {
        recordedGPAs.removeAll()
        recordedSubjecNames.removeAll()
        calculateKey = true
        table.reloadData()
    }
    
    
    @IBAction func onAddSubject(_ sender: UIButton) {
        calculateKey = false
        subjectCount+=1
        recordedGPAs.removeAll()
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
            recordedGPAs.removeAll()
            subjectCount = 1
            semesterOne = false
            semesterTwo = true
            table.reloadData()
        default:
            recordedGPAs.removeAll()
            subjectCount = 1
            semesterOne = true
            semesterTwo = false
            table.reloadData()
        }
    }
}

//MARK: tableview config and GPA calculation
extension SubjectGPAViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SubjectGPATableViewCell
        
        //MARK: Calculating the respective GPAs
        if(calculateKey!){
            calculateGPA(cell: cell!)
        }
        
        //MARK: Saving the names of subjects and their respective GPAs (so it can be used in semester GPA calculator)
        save()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            table.beginUpdates()
            
            subjectCount -= 1
            table.deleteRows(at: [indexPath], with: .left)
            
            table.endUpdates()
        }
    }
    
    
    func calculateGPA(cell: SubjectGPATableViewCell){
        if cell.subjectName?.text != "" && (cell.subjectScore?.text)! != "" && containsALetter(string: cell.subjectScore.text!) == false {// if no name is entered or the score string contains a letter
            if Int((cell.subjectScore.text)!)! <= 100 && Int((cell.subjectScore?.text)!)! >= 0  { // it is impossible to get less than 0 and more than 100 as a score
                
                cell.subjectName?.layer.borderWidth = 2
                cell.subjectScore.layer.borderWidth = 2
                
                cell.subjectName!.layer.borderColor = CGColor(red: 1.00, green: 0.00, blue: 0.49, alpha: 1.00)
                cell.subjectScore!.layer.borderColor = CGColor(red: 0.03, green: 0.00, blue: 0.68, alpha: 1.00)
                
                recordedSubjecNames.append((cell.subjectName?.text)!)
                    
                if Double(Int((cell.subjectScore.text)!) ?? 0) <= 50 { //uni rule - score below 50 is automatic 0 subject gpa
                    recordedGPAs[(cell.subjectName?.text)!] = 0.0
                    cell.GPALabel.text = "= 0.0"
                }
                else{
                    let gpa = (Double(Int((cell.subjectScore.text)!)!) - 50) * 0.06 + 1.0 // subject GPA formula
                    recordedGPAs[(cell.subjectName?.text)!] = gpa// storing the GPA in a dictionary coresponding to the subject name
                    cell.GPALabel.text = "= \(gpa)"
                }
            }
        }
        
        else if cell.subjectName?.text == ""{
            cell.subjectName!.layer.borderWidth = 4
            cell.subjectName!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
        else if containsALetter(string: cell.subjectScore.text!) || Int((cell.subjectScore.text)!)! > 100 || Int((cell.subjectScore.text)!)! < 0{
            cell.subjectScore!.layer.borderWidth = 4
            cell.subjectScore!.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func save() {
        if semesterOne{
            defaults.setValue(recordedGPAs, forKey: "semester1GPAs")
            defaults.setValue(recordedSubjecNames, forKey: "semester1SubjectNames")
        }
        else if semesterTwo{
            defaults.setValue(recordedGPAs, forKey: "semester2GPAs")
            defaults.setValue(recordedSubjecNames, forKey: "semester2SubjectNames")
        }
    }
    
    func containsALetter(string:String)->Bool{
        for letter in string{
            if(letters.contains(String(letter))){
                return true
            }
            else {return false}
        }
        return true
    }
}
