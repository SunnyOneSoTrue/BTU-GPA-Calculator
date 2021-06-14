//
//  SubjectGPATableViewCell.swift
//  BTU GPU calculator
//
//  Created by USER on 20.05.21.
//

import UIKit

class SubjectGPATableViewCell: UITableViewCell{

    @IBOutlet weak var subjectName: UITextField?
    @IBOutlet weak var subjectScore: UITextField!
    @IBOutlet weak var GPALabel: UILabel!
    
    @IBOutlet weak var subjectNameLabel: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
