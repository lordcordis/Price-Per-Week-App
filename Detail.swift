//
//  ProductStaticTableViewController.swift
//  PricePerWeek
//
//  Created by Роман Коренев on 13/06/2019.
//  Copyright © 2019 Роман Коренев. All rights reserved.
//

import UIKit

class ItemStaticTableViewController: UITableViewController {
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        view.endEditing(true)
    //    }
    
    var importedItem: Item?
    var delegate: ItemDelegate?
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var detailDateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var priceTF: UITextField!
    
    
    private let dateIndexPath = IndexPath(row: 0, section: 1)
    private let rollIndexPath = IndexPath(row: 1, section: 1)
    
    var isDatePickerShown = false {
        didSet {
            datePicker.isHidden = !isDatePickerShown
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailDateLabel.text = importedItem?.dateAsString
        updateView()
        updateRoll()
        
        
    }
    
    func updateView(){
        nameTF.text = importedItem?.name
        guard let item = importedItem else {return}
        let priceString = String(item.price)
        priceTF.text = priceString
    }
    
    func updateRoll(){
        guard let date = importedItem?.date else {return}
        datePicker.date = date
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath == rollIndexPath {
            guard isDatePickerShown else {
                return 0.0
            }
            return 150.0
        } else {
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == dateIndexPath {
            isDatePickerShown = !isDatePickerShown
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: false)
            
            let date = datePicker.date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            detailDateLabel.text = formatter.string(from: date)
        }
    }
    
    
    
    @IBAction func itemsBarButton(_ sender: Any) {
        
    }
    
    
    @IBAction func barButton(_ sender: Any) {
        
        guard let priceString = priceTF.text, let name = nameTF.text else {return}
        guard let price = Int(priceString) else {return}
        
        if importedItem != nil {
            let editedItem = Item(name: name, price: price, date: datePicker.date)
            delegate?.editItem(item: editedItem)
            dismiss(animated: true)
            
            
        } else {
            let newItem = Item(name: name, price: price, date: datePicker.date)
            delegate?.addItem(item: newItem)
            dismiss(animated: true) {
            }
        }
    }
}

protocol ItemDelegate {
    func addItem (item: Item)
    func editItem(item: Item)
}
