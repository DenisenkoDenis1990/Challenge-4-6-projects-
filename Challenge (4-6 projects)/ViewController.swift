//
//  ViewController.swift
//  Challenge (4-6 projects)
//
//  Created by Denys Denysenko on 21.10.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain, target: self, action: #selector(clearAll))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        toolbarItems = [share]
        navigationController?.isToolbarHidden = false
        
        
    }
    
    @objc func shareList(){
        
        let list = shoppingList.joined(separator: "\n")
        let ac = UIActivityViewController(activityItems: [list], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationController?.toolbarItems?[0]
        present(ac, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    @objc func addItem () {
        
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addShopingItem = UIAlertAction(title: "Add", style: .default) {
            [weak self , weak ac] action in
            guard let item = ac?.textFields?[0].text else {return}
            
            self?.submit(item)
        }
        
        ac.addAction(addShopingItem)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    
    func submit ( _ item : String) {
        
        let lowercaseItem = item.lowercased()
        shoppingList.insert(lowercaseItem, at: 0)
       
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        
    }
    
   @objc func clearAll () {
        
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
}

