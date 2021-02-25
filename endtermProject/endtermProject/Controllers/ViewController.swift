//
//  ViewController.swift
//  endtermProject
//
//  Created by Miras Alimov on 24.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var history: [String] = []
    var artistSearch: ArtistSearch?
    var trackSearch: TrackSearch?
    let decoder: JSONDecoder = JSONDecoder()
    var playlist = Set<Track>()
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.nib, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.register(ArtistTableViewCell.nib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.register(TrackTableViewCell.nib, forCellReuseIdentifier: TrackTableViewCell.identifier)
    }


    @IBAction func segmentSwitched(_ sender: Any) {
        tableView.reloadData()
    }
    
    func fetchData(_ text: String) {
        let urlArtist = Constants.baseUrl + "method=artist.search&artist="+text+"&api_key="+Constants.key+"&format=json"
        AF.request(urlArtist).responseJSON { (response) in
                    switch response.result{
                    case .success(_):
                        guard let data = response.data else { return }
                        do{
                            let answer = try self.decoder.decode(ArtistSearch.self, from: data)
                            self.artistSearch = answer
                        }catch{
                            print("Parsing error")
                        }
                    case .failure(let err):
                        print(err.errorDescription ?? "")
                    }
                }
        let urlTrack = Constants.baseUrl + "method=track.search&track="+text+"&api_key="+Constants.key+"&format=json"
        AF.request(urlTrack).responseJSON { (response) in
                    switch response.result{
                    case .success(_):
                        guard let data = response.data else { return }
                        do{
                            let answer = try self.decoder.decode(TrackSearch.self, from: data)
                            self.trackSearch = answer
                        }catch{
                            print("Parsing error")
                        }
                    case .failure(let err):
                        print(err.errorDescription ?? "")
                    }
                }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO add other track, artist, album num
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return history.count
        case 1:
            return trackSearch?.results.trackmatches.track.count ?? 0
        case 2:
            return artistSearch?.results.artistmatches.artist.count ?? 0
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return historyCell(tableView, indexPath)
        case 1:
            return trackCell(tableView, indexPath)
        case 2:
            return artistCell(tableView, indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
            searchBar.text = cell.historyLabel.text
            fetchData(searchBar.text!)
            tableView.reloadData()
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let item = trackSearch?.results.trackmatches.track[indexPath.row]
            playlist.insert(item!)
            let vc = tabBarController?.viewControllers![1] as! PlaylistViewController
            vc.playlist = playlist
        } else if segmentedControl.selectedSegmentIndex == 2 {
            let cell = tableView.cellForRow(at: indexPath) as! ArtistTableViewCell
            let urlArtistInfo = Constants.baseUrl + "method=artist.getInfo&api_key="+Constants.key+"&format=json&mbid="+cell.mbid
            AF.request(urlArtistInfo).responseJSON { (response) in
                        switch response.result{
                        case .success(_):
                            guard let data = response.data else { return }
                            do{
                                let answer = try self.decoder.decode(ArtistInfo.self, from: data)
                                let vc = self.storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
                                vc.artist = answer.artist
                                self.navigationController?.pushViewController(vc, animated: true)
                            }catch{
                                print("Parsing error")
                            }
                        case .failure(let err):
                            print(err.errorDescription ?? "")
                        }
                    }
        }
    }
    
    func historyCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as! HistoryTableViewCell
        cell.historyLabel.text = history[indexPath.row]
        return cell
    }
    
    func artistCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as! ArtistTableViewCell
        let item = artistSearch?.results.artistmatches.artist[indexPath.row]
        cell.artistName.text = item?.name
        cell.artistImg.load(urlString: (item?.image[1].img)!)
        cell.mbid = item!.mbid
        return cell
    }
    
    func trackCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier) as! TrackTableViewCell
        let item = trackSearch?.results.trackmatches.track[indexPath.row]
        cell.trackLabel.text = item?.name
        cell.artistLabel.text = item?.artist
        cell.trackImage.load(urlString: item?.image[1].img ?? "")
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        appendData(text)
        fetchData(text)
    }
    
    func appendData(_ text: String) {
        for hist in history {
            if hist == text {
                return
            }
        }
        history.append(text)
    }
}
