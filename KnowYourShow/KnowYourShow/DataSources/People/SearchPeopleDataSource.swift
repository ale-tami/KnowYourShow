//
//  SearchPeopleDataSource.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
protocol SearchPeopleDataSourceDelegate  {
    func showSelected(people:People)
}
class SearchPeopleDataSource: NSObject, UITableViewDelegate {
    private weak var vc:SearchPeopleViewController!
    private var people:[People] = []
    private var lastRowIndexPath:IndexPath!
    private var timer: Timer!
    var delegate:SearchPeopleDataSourceDelegate?
    
    init(vc:SearchPeopleViewController) {
        self.vc = vc
    }
    
    func update(people:[People]) {
        self.people = people
        self.vc.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.showSelected(people: self.people[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension SearchPeopleDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        if let urlStr = people[indexPath.row].imageMediumUrl, let url = URL(string: urlStr) {
            cell?.imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (result) in
                tableView.reloadRows(at: [indexPath], with: .none)
            })
        }
        
        cell?.imageView?.layer.cornerRadius = 22
        cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        cell?.imageView?.layer.borderWidth = 1
        cell?.imageView?.layer.masksToBounds = true
        
        cell?.textLabel?.text = people[indexPath.row].name
        
        if let date = people[indexPath.row].birthday {
            let dateo = DateFormatter.formatForReceivingDate.date(from:date)
            let dob = DateFormatter.formatForShowingDate.string(from: dateo ?? Date())
            cell?.detailTextLabel?.text = "DoB: \(dob)"
        } else {
            cell?.detailTextLabel?.text = "DoB: Date not available"
        }
        if let date = people[indexPath.row].deathday {
            let dateo = DateFormatter.formatForReceivingDate.date(from:date)
            let dod = DateFormatter.formatForShowingDate.string(from: dateo ?? Date())
            cell?.detailTextLabel?.text?.append(" - DoD: \(dod)")
        }
       
        return cell ?? UITableViewCell()
    }
}

extension SearchPeopleDataSource:UISearchBarDelegate {
    
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
        self.vc.peopleInteractor.getPeople(with: vc.searchBar.text ?? "")
    }
}


