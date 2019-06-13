//
//  MainTableViewCell.swift
//  PricePerWeek
//
//  Created by Роман Коренев on 13/06/2019.
//  Copyright © 2019 Роман Коренев. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var item: Item?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populateCell(){
        nameLabel.text = item?.name
        dateLabel.text = item?.dateAsString
        guard let priceInt = item?.pricePerWeek else {return}
        priceLabel.text = "\(priceInt) RUR per week"
        
    }
    
}
