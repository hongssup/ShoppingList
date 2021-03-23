//
//  ViewController.swift
//  ShoppingList
//
//  Created by SeoYeon Hong on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let titleView = UIView()
    let titleText = UILabel()
    var items:[String] = []
    var color = UIColor()
    let inputText = UITextField()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        addConstraints()
    }
    
    func setupTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setupView() {
        color = UIColor(red: 239/255, green: 144/255, blue: 109/255, alpha: 1.0)
        titleView.backgroundColor = color
        titleText.text = "쇼핑리스트"
        titleText.textColor = .white
        titleText.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(titleView)
        view.addSubview(titleText)
        view.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.sizeToFit()
        }
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 48),
            titleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            
            titleText.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? ItemCell {
            //cell.textField.placeholder = "입력하세요"
            cell.textField.font = UIFont.systemFont(ofSize: 20)
            cell.checkButton.setTitleColor(color, for: .normal)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        //footerView.backgroundColor = .gray
        let addButton = UIButton()
        addButton.layer.cornerRadius = 12
        addButton.frame = CGRect(x: 20, y: 20, width: 32, height: 32)
        addButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 28, style: .solid)
        addButton.setTitle(.fontAwesomeIcon(name: .plus), for: .normal)
        addButton.setTitleColor(color, for: .normal)
        addButton.addTarget(self, action: #selector(addList), for: .touchUpInside)
        //addButton.backgroundColor = color
        footerView.addSubview(addButton)
        return footerView
    }
    
    @objc func addList() {
        items.append("")
        tableView.reloadData()
    }
}
