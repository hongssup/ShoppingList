//
//  ListDAO.swift
//  ShoppingList
//
//  Created by SeoYeon Hong on 2021/03/29.
//

import Foundation
import UIKit
import CoreData

public class ListDAO {
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "items")
        let result = try! context.fetch(fetchRequest)
        return result
    }
}
