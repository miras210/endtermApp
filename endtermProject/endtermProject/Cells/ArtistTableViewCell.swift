//
//  ArtistTableViewCell.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    public static let identifier = "ArtistTableViewCell"
    public static let nib = UINib(nibName: "ArtistTableViewCell", bundle: nil)
    @IBOutlet weak var artistImg: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    var mbid: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
