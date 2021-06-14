//
//  SemesterTableViewCell.swift
//  BTU GPU calculator
//
//  Created by USER on 09.06.21.
//

import UIKit

class SemesterTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectNameField: UITextField!
    @IBOutlet weak var subjectGPAField: UITextField!
    @IBOutlet weak var subjectCreditField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
