//
//  PlaylistViewController.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    var playlist =  Set<Track>()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrackTableViewCell.nib, forCellReuseIdentifier: TrackTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}


extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as! TrackTableViewCell
        let item = playlist[playlist.index(playlist.startIndex, offsetBy: indexPath.row)]
        cell.trackLabel.text = item.name
        cell.artistLabel.text = item.artist
        cell.trackImage.load(urlString: item.image[1].img)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
                    [weak self] (action, view, completionHandler) in
            self?.playlist.remove(self!.playlist[self!.playlist.index(self!.playlist.startIndex, offsetBy: indexPath.row)])
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                    completionHandler(true)
                }
        delete.backgroundColor = .systemRed
        let conf = UISwipeActionsConfiguration(actions: [delete])
        let vc = tabBarController?.viewControllers![0] as! ViewController
        vc.playlist = playlist
        return conf
    }
}
