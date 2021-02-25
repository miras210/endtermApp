//
//  TrackTableViewCell.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    public static let identifier = "TrackTableViewCell"
    public static let nib = UINib(nibName: "TrackTableViewCell", bundle: nil)
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    
    var playlistCallback: ((_ isOn: Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
