//
//  SearchShowsViewController.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 21/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchShowsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var tableViewDataSource:SearchDataSource!
    var paginateShowsinteractor:PaginatedShowsInteractor = PaginatedShowsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupInteractor()
        self.setUpSearchController()
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "EntertainmentTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        //Purpousfully tightly coupled, it must be a 1-1 relationship, and usually these 2 go in the same file, but i prefer to have them separated to keep the vc as thin as possible
        self.tableViewDataSource = SearchDataSource(vc: self)
        self.tableView.delegate = tableViewDataSource
        self.tableView.dataSource = tableViewDataSource
    }
    
    private func setupInteractor(){
        self.paginateShowsinteractor.delegate = self
        self.paginateShowsinteractor.getShows()
    }
    
    private func setUpSearchController() {
        self.searchBar.delegate = self.tableViewDataSource
        self.searchBar.placeholder = "Search by Show name"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let show = sender as? Show else { return }
        if let vc = segue.destination as? DetailsTableViewController{
            vc.show = show
        }
    }
}

extension SearchShowsViewController:ShowSearchDelegate {
    func receivedShows(shows: [Show]) {
        self.tableViewDataSource.update(shows: shows)
    }
    
    func failedToReceiveShow(errorStr: String) {
        AlertHelper.presentErrorAlert(with: errorStr, in: self)
    }
    
}
