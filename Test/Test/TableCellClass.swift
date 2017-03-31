//
//  TableCellClass.swift
//  Test
//
//  Created by Samuel Wairegi on 31/03/2017.
//  Copyright © 2017 Test. All rights reserved.
//
import UIKit

class TableCellClass: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var textName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}