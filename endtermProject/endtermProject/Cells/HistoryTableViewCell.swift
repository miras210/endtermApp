//
//  HistoryTableViewCell.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyLabel: UILabel!
    public static let identifier = "HistoryTableViewCell"
    public static let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
