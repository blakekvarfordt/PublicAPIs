//
//  DatabaseTableViewController.swift
//  PublicAPIs
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class DatabaseTableViewController: UITableViewController {

    
    var category: String? {
        didSet {
            updateViews()
        }
    }
    
    var databases = [Database]()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatabaseCell", for: indexPath)

        let database = databases[indexPath.row]
        
        cell.textLabel?.text = database.title
        cell.detailTextLabel?.text = database.description

        return cell
    }
    
    
    func updateViews() {
        loadViewIfNeeded()
        
        guard let category = self.category else { return }
        
        DatabaseController.fetchDatabases(category: category) { (fetchedDatabases) in
            DispatchQueue.main.async {
                self.databases = fetchedDatabases
                self.tableView.reloadData()
            }
        }
    }
    
    
}
