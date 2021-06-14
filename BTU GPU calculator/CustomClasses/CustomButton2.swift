//
//  CustomButton.swift
//  BTU GPU calculator
//
//  Created by USER on 14.06.21.
//

import Foundation

import UIKit

@IBDesignable class CustomButton2: UIButton {
    
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
        self.backgroundColor = bgColor
        self.setTitleColor(txtColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    // MARK: - Properties
    @IBInspectable
    var bgColor: UIColor = UIColor(red: 1.00, green: 0.00, blue: 0.49, alpha: 1.00) {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable
    var txtColor: UIColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00) {
        didSet {
            self.tintColor = bgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
