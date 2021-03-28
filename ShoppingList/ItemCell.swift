//
//  ItemCell.swift
//  ShoppingList
//
//  Created by SeoYeon Hong on 2021/03/23.
//

import Foundation
import UIKit
import FontAwesome_swift

class ItemCell: UITableViewCell {
    
    let textField = UITextField()
    public let checkButton = UIButton()
    var check: Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        cellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConstraints() {
        textField.textColor = .darkGray
        textField.delegate = self
        checkButton.layer.cornerRadius = 16
        checkButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .regular)
        checkButton.setTitle(.fontAwesomeIcon(name: .circle), for: .normal)
        checkButton.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        //textField.backgroundColor = .gray
        addSubview(textField)
        addSubview(checkButton)
        subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 58),//20
            textField.widthAnchor.constraint(equalToConstant: 330),
            
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            //checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            checkButton.widthAnchor.constraint(equalToConstant: 32),
            checkButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func checkTapped() {
        if check == false {
            checkButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
            checkButton.setTitle(.fontAwesomeIcon(name: .checkCircle), for: .normal)
            textField.textColor = .systemGray4
            textField.isEnabled = false
            check = true
        } else {
            checkButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .regular)
            checkButton.setTitle(.fontAwesomeIcon(name: .circle), for: .normal)
            textField.textColor = .darkGray
            textField.isEnabled = true
            check = false
        }
    }
    
    public func editMode() {
        checkButton.isHidden = true
    }
}

extension ItemCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ViewController().hideFooter(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textFieldIndexPath = self.tag
        print("저장됨")
        ViewController().endTextEdit(textField.text ?? "", textFieldIndexPath)
    }
}
