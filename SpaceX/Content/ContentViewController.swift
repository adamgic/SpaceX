//
//  ContentViewController.swift
//  SpaceX
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import UIKit

class ContentViewController: UITableViewController {

    let cellIdentifier = "LaunchCellId"

    var launches: [Launch] = []
    var filteredLaunches: [Launch] {
        return launches.filter {
            return $0.launchSuccess && showSuccess || !$0.launchSuccess && showFailure
        }
    }

    var showSuccess = true {
        didSet {
            tableView.reloadData()
        }
    }
    var showFailure = true {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadContent), for: .valueChanged)
        tableView.tableFooterView = UIView()

        loadContent()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLaunches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let launchCell = cell as? LaunchCell {
            let launch = filteredLaunches[indexPath.row]
            launchCell.model = launch
        }

        return cell
    }

    @objc func loadContent() {
        refreshControl?.beginRefreshing()
        Content.getLaunches { [weak self] launches in
            self?.launches = launches

            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            detailsViewController.model = filteredLaunches[indexPath.row]

            // extract image from cell to avoid downloading
            detailsViewController.image = (tableView.cellForRow(at: indexPath) as? LaunchCell)?.missionPatchView.image
        }
     }

}

