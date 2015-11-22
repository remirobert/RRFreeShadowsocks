//
//  Shadowsocks.swift
//  RRFreeShadowdocks
//
//  Created by Remi Robert on 22/11/15.
//  Copyright © 2015 Remi Robert. All rights reserved.
//

import UIKit

class Shadowsocks {

    var address: String?
    var port: String?
    var encryption: String?
    var password: String?
    
    init(serverInfo: String) {
        var newString = serverInfo.stringByReplacingOccurrencesOfString(" ", withString: "")
        newString = newString.stringByReplacingOccurrencesOfString("\t", withString: "")
        newString = newString.stringByReplacingOccurrencesOfString("\n", withString: "")
        let infos = newString.componentsSeparatedByString("<h4>")
        
        var indexInfo = 0
        for currentInfo in infos {
            if let componentInformationFirst = currentInfo.componentsSeparatedByString(":").last,
                let componentInformationLast = componentInformationFirst.componentsSeparatedByString("</h4>").first {
                    print("\(componentInformationLast)")
                    switch indexInfo {
                    case 1: self.address = componentInformationLast
                    case 2: self.port = componentInformationLast
                    case 3: self.password = componentInformationLast
                    case 4: self.encryption = componentInformationLast
                    default: break
                    }
            }
            indexInfo += 1
        }
    }
}
