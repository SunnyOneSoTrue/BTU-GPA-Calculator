//
//  CustomButton.swift
//  BTU GPU calculator
//
//  Created by USER on 14.06.21.
//

import Foundation

import UIKit

@IBDesignable class CustomTextFieldBlue: UITextField {
    
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
        self.layer.borderColor = borderColor
        self.textColor = txtColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        
    }
    
    // MARK: - Properties
    
    @IBInspectable
    var txtColor: UIColor = UIColor(red: 0.03, green: 0.00, blue: 0.68, alpha: 1.00) {
        didSet {
            self.tintColor = txtColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 2 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: CGColor =  CGColor(red: 0.03, green: 0.00, blue: 0.68, alpha: 1.00){
        didSet {
            self.layer.borderColor = borderColor
        }
    }
}
