//
//  ShadownsocksDetailServerTableViewController.swift
//  RRFreeShadowdocks
//
//  Created by Remi Robert on 22/11/15.
//  Copyright © 2015 Remi Robert. All rights reserved.
//

import UIKit

class ShadownsocksDetailServerTableViewController: UITableViewController {

    var server: Shadowsocks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "💻"
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: cell.detailTextLabel?.text = server.address
            case 1: cell.detailTextLabel?.text = server.port
            case 2: cell.detailTextLabel?.text = server.encryption
            case 3: cell.detailTextLabel?.text = server.password
            default: break
            }
        }
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            if server.address == nil || server.port == nil || server.encryption == nil || server.password == nil {
                print("informations server incomplete")
                return
            }
            var stringConfig = "Proxy = custom,"
            stringConfig += "\(server.address!),"
            stringConfig += "\(server.port!),"
            stringConfig += "\(server.encryption!),"
            stringConfig += "\(server.password!),"
            stringConfig += "https://dl.dropboxuseercontent.com/u/760466/SSEncrypt.module"
            
            let alertController = UIAlertController(title: "Surge configuration", message: stringConfig, preferredStyle: UIAlertControllerStyle.Alert)
            let actionCopy = UIAlertAction(title: "copy", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
                UIPasteboard.generalPasteboard().string = stringConfig
            })
            let actionCancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alertController.addAction(actionCopy)
            alertController.addAction(actionCancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
