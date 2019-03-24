//
//  ViewController.swift
//  Project1
//
//  Created by Derek McLean on 07/03/2019.
//  Copyright © 2019 McLean Digital Limited. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var websites = [
        "barrheadboy.com",
        "independencelive.net",
        "indylive.radio",
        "randompublicjournal.com",
        "thoughtcontrolscotland.com",
        "wingsoverscotland.com"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Scot Blog!"
        websites.sort(by: <)
        print(websites)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedSite = websites[indexPath.row]
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

