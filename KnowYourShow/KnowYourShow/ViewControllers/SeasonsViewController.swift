//
//  SeasonsViewController.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

protocol SeasonsViewControllerDelegate {
    func didFinishLoading()
    func didSelectEpisode(episode:Episode)
}

class SeasonsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableViewDataSource:SeasonsDataSource!
    private var episodesInteractor:EpisodesInteractor = EpisodesInteractor()
    var showId:Int!
    var delegate:SeasonsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupInteractor()
    }
    
    private func setupTableView() {
        self.tableViewDataSource = SeasonsDataSource(vc: self)
        self.tableViewDataSource.delegate = self
        self.tableView.delegate = tableViewDataSource
        self.tableView.dataSource = tableViewDataSource
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.white
        // since table view utilizes these to estimate its content size, i'm zeroing them so I can get a correct content size
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        
    }
    
    private func setupInteractor(){
        self.episodesInteractor.delegate = self
        self.episodesInteractor.getEpisodes(for: showId)
    }
    
}
extension SeasonsViewController: EpisodesDelegate {
    func receivedEpisodes(episodes: [[Episode]]) {
        self.tableViewDataSource.update(episodes: episodes)
        self.delegate?.didFinishLoading()
    }
    
    func failedToReceiveEpisodes(errorStr: String) {
        AlertHelper.presentErrorAlert(with: errorStr, in: self)
    }
}

extension SeasonsViewController:SeasonDataSourceDelegate {
    func episodeSelected(episode: Episode) {
        self.delegate?.didSelectEpisode(episode: episode)
    }
}
