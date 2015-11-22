//
//  ShadownsocksViewController.swift
//  RRFreeShadowdocks
//
//  Created by Remi Robert on 22/11/15.
//  Copyright © 2015 Remi Robert. All rights reserved.
//

import UIKit

class ShadownsocksViewController: UIViewController {

    let shadowsocksController = ShadowsocksController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ativityIndicator: UIActivityIndicatorView!
    var refreshBar: UIRefreshControl!
    
    func fetchServers() {
        self.shadowsocksController.fetchServers({ (success) -> () in
            
            if self.refreshBar.refreshing {
                self.refreshBar.endRefreshing()
            }
            self.ativityIndicator.stopAnimating()
            self.tableView.hidden = false
            self.tableView.reloadData()
            
            }) { (error) -> () in
                print("error fetch servers : \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ativityIndicator.startAnimating()
        self.ativityIndicator.hidesWhenStopped = true
        self.tableView.hidden = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
     
        self.refreshBar = UIRefreshControl()
        self.refreshBar.addTarget(self, action: "fetchServers", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshBar)
        
        self.fetchServers()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "serverDetailSegue" {
            (segue.destinationViewController as! ShadownsocksDetailServerTableViewController).server = sender as! Shadowsocks
        }
    }
}

extension ShadownsocksViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shadowsocksController.servers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serverCell")!
        
        let currentServer = self.shadowsocksController.servers[indexPath.row]
        if let serverName = currentServer.address {
            cell.textLabel?.text = serverName
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        else {
            cell.textLabel?.text = "undifned"
            cell.textLabel?.textColor = UIColor.redColor()
        }
        return cell
    }
}

extension ShadownsocksViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("serverDetailSegue", sender: self.shadowsocksController.servers[indexPath.row])
    }
}