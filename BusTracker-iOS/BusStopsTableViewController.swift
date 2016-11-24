//
//  BusStopsTableViewController.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 23/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class BusStopsTableViewController: UITableViewController {
    let lyonBusStopsURLString = "https://download.data.grandlyon.com/ws/rdata/tcl_sytral.tclarret/all.json?compact=false&start=1&maxfeatures=10000"
    
    var lyonBusStops = [BusStop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Bus Stops"
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    func fetchJSON() {
        if let url = URL(string: lyonBusStopsURLString) {
            if let json = JSONUtils.loadData(from: url) {
                if let _ = json["values"].array {
                    parse(json: json)
                    return
                }
            }
        }
        
        performSelector(onMainThread: #selector(showNetworkErrorMessage), with: nil, waitUntilDone: false)
    }
    
    func parse(json: JSON) {
        for value in json["values"].arrayValue {
            let stopId = value["id"].stringValue
            let stopName = value["nom"].stringValue
            let stopService = value["desserte"].stringValue
            
            lyonBusStops.append(BusStop(id: stopId, name: stopName, service: stopService))
        }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    // Called when JSON could not be loaded
    func showNetworkErrorMessage() {
        let ac = UIAlertController(title: "Network Error", message: "You might want to check your network connection, we couldn't load data from Internet.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyonBusStops.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusStop", for: indexPath)

        let stop = lyonBusStops[indexPath.item]
        cell.textLabel?.text = stop.name

        return cell
    }
}
