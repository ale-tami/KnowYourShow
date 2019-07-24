//
//  SearchPeopleViewController.swift
//  KnowYourShow
//
//  Created by Alejandro Cesar Tami on 24/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit

class SearchPeopleViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var tableViewDataSource:SearchPeopleDataSource!
    var peopleInteractor:PeopleInteractor<SearchPeopleViewController> = PeopleInteractor()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupInteractor()
        self.setUpSearchController()
        
    }
    
    private func setupTableView() {
        self.tableViewDataSource = SearchPeopleDataSource(vc: self)
        self.tableViewDataSource.delegate = self
        self.tableView.delegate = tableViewDataSource
        self.tableView.dataSource = tableViewDataSource
    }
    
    private func setupInteractor(){
        self.peopleInteractor.delegate = self
    }
    
    private func setUpSearchController() {
        self.searchBar.delegate = self.tableViewDataSource
        self.searchBar.placeholder = "Search by Person's name"
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
extension SearchPeopleViewController:SearchPeopleDataSourceDelegate {
    func showSelected(people: People) {
        self.performSegue(withIdentifier: "toDetails", sender: show)
    }
}

extension SearchPeopleViewController:BaseDelegate  {
    typealias T = [People]
    
    func received(objects: [People]) {
        self.tableViewDataSource.update(people: objects)
    }
    
    func failedToReceiveObjects(errorStr: String) {
        AlertHelper.presentErrorAlert(with: errorStr, in: self)
    }
    
}
