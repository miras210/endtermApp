//
//  InfoViewController.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    var artist: ArtistWithBio = ArtistWithBio(name: "nil", image:[], bio: Bio(published: "nil", summary: "nil"))
    override func viewDidLoad() {
        super.viewDidLoad()
        artistImage.load(urlString: artist.image[3].img)
        nameLabel.text = artist.name
        dateLabel.text = artist.bio.published
        summaryLabel.text = artist.bio.summary
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
