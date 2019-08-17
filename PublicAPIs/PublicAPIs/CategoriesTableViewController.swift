//
//  CategoriesTableViewController.swift
//  PublicAPIs
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    
    var categories = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseController.fetchCategories { (categories) in
            DispatchQueue.main.async {
                self.categories = categories
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category

        return cell
    }
    


    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDatabases" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destination = segue.destination as? DatabaseTableViewController else { return }
            let category = self.categories[indexPath.row]
            destination.category = category
        }
    }
    

}
