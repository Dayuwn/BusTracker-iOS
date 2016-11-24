//
//  ViewController.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 22/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class BusLinesViewController: UITableViewController {
    let lyonBusLinesURLString = "https://download.data.grandlyon.com/ws/rdata/tcl_sytral.tcllignebus/all.json"
    
    var lyonBusLines = [BusLine]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    // Gets Lyon's bus lines' data as JSON
    // Ran on background thread
    func fetchJSON() {
        if let url = URL(string: lyonBusLinesURLString) {
            if let json = JSONUtils.loadData(from: url) {
                if json["values"].arrayValue != [] {
                    parse(json: json)
                    return
                }
            }
        }

        performSelector(onMainThread: #selector(showNetworkErrorMessage), with: nil, waitUntilDone: false)
    }
    
    // Parses the JSON. Only gets the information we want for each bus line.
    // Ran on background thread
    func parse(json: JSON) {
        for value in json["values"].arrayValue {
            let lineDirections = value["libelle"].stringValue.components(separatedBy: "-")
            
            let lineName = value["ligne"].stringValue.uppercased()
            let lineStart = lineDirections[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let lineTerminus = lineDirections[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let lineDirection = value["sens"].stringValue
            let lineId = value["code_titan"].stringValue
            
            let busLine = BusLine(name: lineName, start: lineStart, terminus: lineTerminus, direction: lineDirection, id: lineId)
            lyonBusLines.append(busLine)
        }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    // Called when JSON could not be loaded
    func showNetworkErrorMessage() {
        let ac = UIAlertController(title: "Network Error", message: "You might want to check your network connection, we couldn't load data from Internet.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyonBusLines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusLine") as! BusLineCell
        
        let line = lyonBusLines[indexPath.item]
        cell.lineNameLabel.text = line.name
        cell.lineStartLabel.text = line.start
        cell.lineTerminusLabel.text = line.terminus
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

