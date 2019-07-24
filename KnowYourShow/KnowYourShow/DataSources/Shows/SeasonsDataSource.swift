//
//  SeasonsDataSource.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 23/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import Kingfisher

protocol SeasonDataSourceDelegate {
    func episodeSelected(episode:Episode)
}

class SeasonsDataSource:NSObject, UITableViewDelegate {

    private weak var vc:SeasonsViewController!
    private var episodes:[[Episode]] = []
    var delegate:SeasonDataSourceDelegate?
    
    init(vc:SeasonsViewController) {
        self.vc = vc
    }
    
    func update(episodes:[[Episode]]) {
        self.episodes = episodes
        self.vc.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.episodeSelected(episode: episodes[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}

extension SeasonsDataSource:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = episodes[indexPath.section][indexPath.row].name
        if let urlStr = episodes[indexPath.section][indexPath.row].imageMediumUrl, let url = URL(string: urlStr) {
            cell?.imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (result) in
                tableView.reloadRows(at: [indexPath], with: .none)                
            })
        }
        let epNum = episodes[indexPath.section][indexPath.row].number
        let epSeas = episodes[indexPath.section][indexPath.row].season
        let epAir = episodes[indexPath.section][indexPath.row].airDate
        let epTime = episodes[indexPath.section][indexPath.row].airTime
        var epDate = "-"
        if let air = epAir {
            let date = DateFormatter.formatForReceivingDate.date(from:air)
            epDate = DateFormatter.formatForShowingDate.string(from: date ?? Date())
        }
        var epTim = "-"
        if let time = epTime {
            epTim = time
        }
        cell?.detailTextLabel?.text = "S\(epSeas)E\(epNum) | \(epDate) - \(epTim)hs"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  Season \(section + 1)"
    }
    
}
