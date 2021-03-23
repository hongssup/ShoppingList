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
    let addButton = UIButton()
    let editButton = UIButton()
    let trashButton = UIButton()
    //let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: (#selector(showEditing)))
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSubView()
        addConstraints()
    }
    
    func setupTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isEditing = false
        //tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setupSubView() {
        color = UIColor(red: 239/255, green: 144/255, blue: 109/255, alpha: 1.0)
        //title = "쇼핑리스트"
        
        titleView.backgroundColor = color
        titleText.text = "쇼핑리스트"
        titleText.textColor = .white
        titleText.font = UIFont.boldSystemFont(ofSize: 20)
        editButton.setTitle("편집", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.addTarget(self, action: #selector(showEditing), for: .touchUpInside)
        trashButton.setTitle(.fontAwesomeIcon(name: .trashAlt), for: .normal)
        trashButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 22.5, style: .regular)
        trashButton.setTitleColor(.white, for: .normal)
        trashButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        //navigationItem.rightBarButtonItem = editButton
        
        view.addSubview(titleView)
        view.addSubview(titleText)
        view.addSubview(editButton)
        view.addSubview(trashButton)
        view.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.sizeToFit()
        }
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 44),
            titleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            
            titleText.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 44),
            
            editButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            trashButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            trashButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 22)
            //editButton.widthAnchor
        ])
    }
    
    @objc func showEditing() {
        if tableView.isEditing == true {
            tableView.isEditing = false
            editButton.setTitle("편집", for: .normal)
            addButton.isHidden = false
        } else {
            tableView.isEditing = true
            editButton.setTitle("완료", for: .normal)
            addButton.isHidden = true
        }
    }
    
    @objc func deleteAll() {
        items = []
        tableView.reloadData()
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
        
        addButton.layer.cornerRadius = 12
        addButton.frame = CGRect(x: 20, y: 16, width: 32, height: 32)
        addButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
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
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            items.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_,_,completionHandler) in
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(movedObject, at: destinationIndexPath.row)
    }
}
