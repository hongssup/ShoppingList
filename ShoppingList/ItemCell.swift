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
    let checkButton = UIButton()
    var check: Bool = false
    
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
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 330),
            
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            checkButton.widthAnchor.constraint(equalToConstant: 32),
            checkButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func checkTapped() {
        if check == false {
            checkButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
            checkButton.setTitle(.fontAwesomeIcon(name: .checkCircle), for: .normal)
            textField.textColor = .systemGray4
            check = true
        } else {
            checkButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .regular)
            checkButton.setTitle(.fontAwesomeIcon(name: .circle), for: .normal)
            textField.textColor = .darkGray
            check = false
        }
    }
}
