//
//  SearchDataSource.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 21/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import Kingfisher

protocol SearchDataSourceDelegate {
    func showSelected(show:Show)
}
class SearchDataSource:NSObject, UITableViewDelegate {
    
    private weak var vc:SearchShowsViewController!
    private var shows:[Show] = []
    private var lastRowIndexPath:IndexPath!
    private var timer: Timer!
    var delegate:SearchDataSourceDelegate?

    init(vc:SearchShowsViewController) {
        self.vc = vc
    }
    
    func update(shows:[Show]) {
        self.shows = shows
        self.vc.tableView.reloadData()
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.showSelected(show: self.shows[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 50.0 {
            self.vc.paginateShowsinteractor.getShows()
        }
    }

}

extension SearchDataSource:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EntertainmentTableViewCell
        
       
        if let urlStr = shows[indexPath.row].imageMediumUrl, let url = URL(string: urlStr) {
            cell?.setImage(with: url)
        }
        cell?.titleLabel.text = shows[indexPath.row].name
        
        if let date = shows[indexPath.row].premiered {
            let dateo = DateFormatter.formatForReceivingDate.date(from:date)
            let showDate = DateFormatter.formatForShowingDate.string(from: dateo ?? Date())
            cell?.dateLabel?.text = "Aired: \(showDate)"
        } else {
            cell?.dateLabel?.text = "Aired date not available"
        }
       
        cell?.ratingLabel?.text = "Rate: \(shows[indexPath.row].rate ?? 0.0)"
        
        return cell ?? UITableViewCell()
    }
    
}

extension SearchDataSource:UISearchBarDelegate {
    
    func startTimer () {
        self.timer?.invalidate()
        self.timer =  Timer.scheduledTimer(
            timeInterval: TimeInterval(1.0),
            target      : self,
            selector    : #selector(search),
            userInfo    : nil,
            repeats     : false)
        
    }
    
    func stopTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let currentText = self.vc.searchBar.text ?? ""
        if currentText.isEmpty && searchText.isEmpty{
            self.update(shows: self.vc.paginateShowsinteractor.getCurrentPaginatedShows())
            return
        }
        
        self.startTimer()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.vc.searchBar.endEditing(true)
        self.vc.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.vc.searchBar.endEditing(true)
        self.vc.view.endEditing(true)
        self.search(searchBar)
    }
    
    @objc private func search(_ searchBar: UISearchBar) {
        self.stopTimer()
        self.vc.paginateShowsinteractor.getShows(with: vc.searchBar.text ?? "")
    }
}
