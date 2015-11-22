//
//  ShadowsocksParserResponse.swift
//  RRFreeShadowdocks
//
//  Created by Remi Robert on 22/11/15.
//  Copyright © 2015 Remi Robert. All rights reserved.
//

import UIKit

class ShadowsocksParserResponse: NSObject {

    
    class func parseResponse(responseString: String) -> [Shadowsocks] {
        var servers = Array<Shadowsocks>()
        
        if let serversListDiv = responseString.componentsSeparatedByString("<!-- Free Shadowsocks Section -->").last {
            let serversListArrayDiv = serversListDiv.componentsSeparatedByString("<div class=\"row\">")[2]
            
            let serversListInfoArrayDiv = serversListArrayDiv.componentsSeparatedByString("<div class=\"col-lg-4 text-center\">")
            
            for currentServerInfo in serversListInfoArrayDiv {
                let newServer = Shadowsocks(serverInfo: currentServerInfo)
                if newServer.address != nil {
                    servers.append(newServer)
                }
            }
        }
        return servers
    }
}
