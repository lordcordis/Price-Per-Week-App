//
//  MainTableViewController.swift
//  PricePerWeek
//
//  Created by Роман Коренев on 13/06/2019.
//  Copyright © 2019 Роман Коренев. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var itemList = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
        let item = itemList[indexPath.row]
        cell.item = item
        cell.populateCell()
        
        return cell
    }
    
    
    

     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        itemList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
     }

    }

     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedItem = itemList.remove(at: fromIndexPath.row)
        itemList.insert(movedItem, at: to.row)
        tableView.reloadData()
        
        
     }

    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "editSegue" {
            guard let itemNavVC = segue.destination as? UINavigationController, let indexPathSelected = tableView.indexPathForSelectedRow else {return}
            let itemVC = itemNavVC.topViewController as? ItemStaticTableViewController
            itemVC?.importedItem = itemList[indexPathSelected.row]
            itemVC?.delegate = self
            
        } else if segue.identifier == "addSegue" {
            let itemNavVC = segue.destination as? UINavigationController
            let itemVC = itemNavVC?.topViewController as? ItemStaticTableViewController
            itemVC?.delegate = self
        }
    }
    
    
    @IBAction func itemBarButton(_ sender: Any) {
        countItems()
    }
}


extension MainTableViewController: ItemDelegate{
    func editItem(item: Item) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            itemList[selectedRow.row] = item
            tableView.reloadData()
            saveData()
            print("DELEGATE EDITED")
        }
    }
    
    func addItem(item: Item) {
        dismiss(animated: true)
        itemList.append(item)
        print("delegate ADDED")
        saveData()
        tableView.reloadData()
    }
    
    
    
    func countItems(){
        
        var currentSum = 0
        for item in itemList{
            let current = item.pricePerWeek
            currentSum += current
        }
        let alert = UIAlertController(title: "Cost per week", message: "\(currentSum) RUR", preferredStyle: .alert)
        let okActon = UIAlertAction(title: "K", style: .cancel, handler: nil)
        alert.addAction(okActon)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}


extension MainTableViewController {
    func documentsFolder()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePath()-> URL {
        return documentsFolder().appendingPathComponent("data.plist")
    }
    
    
    
    func saveData(){
        do {
            let plistEnc = PropertyListEncoder()
            let savedata = try plistEnc.encode(itemList)
            try savedata.write(to: savePath())
            print("data saved")
        } catch {
            print("error saving data")
        }
    }
    
    func loadData(){
        
        do {
            let retrievedData = try Data(contentsOf: savePath())
            let plistDec = PropertyListDecoder()
            let itemData = try plistDec.decode([Item].self, from: retrievedData)
            self.itemList = itemData
            
            print("data loaded")
        } catch {
            print("error loading data")
        }
        
    }
}
