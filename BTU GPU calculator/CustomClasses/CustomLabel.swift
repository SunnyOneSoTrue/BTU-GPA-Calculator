//
//  CustomButton.swift
//  BTU GPU calculator
//
//  Created by USER on 14.06.21.
//

import Foundation

import UIKit

@IBDesignable class CustomLabel: UILabel {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - UI Setup
    override func prepareForInterfaceBuilder() {
        setupView()
    }

    func setupView() {
        self.font = fnt
        self.textColor = txtColor

    }

    // MARK: - Properties

    @IBInspectable
    var txtColor: UIColor = UIColor(red: 1.00, green: 0.00, blue: 0.49, alpha: 1.00){
        didSet {
            self.tintColor = txtColor
        }
    }
    
    @IBInspectable
    var fnt: UIFont? = UIFont(name: "Arial", size: 36) {
        didSet {
            self.font = fnt
        }
    }
}
