//
//  ShadowsocksController.swift
//  RRFreeShadowdocks
//
//  Created by Remi Robert on 22/11/15.
//  Copyright © 2015 Remi Robert. All rights reserved.
//

import UIKit

extension NSData {
    func convertToJson() -> String {
        return NSString(bytes: self.bytes, length: self.length, encoding: NSUTF8StringEncoding)! as String
    }
}

class ShadowsocksController: NSObject, NSURLConnectionDataDelegate {

    var servers = Array<Shadowsocks>()
    var receiveData: NSMutableData!
    var request: NSMutableURLRequest! = {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.ishadowsocks.com")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 60)
        request.HTTPMethod = "GET"
        return request
    }()
    var completionBlock: ((success: Bool) -> ())?
    var errorBlock: ((error: NSError!) -> ())?
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.errorBlock?(error:error)
        self.completionBlock?(success: false)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.servers = ShadowsocksParserResponse.parseResponse(self.receiveData.convertToJson())
        self.completionBlock?(success: true)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.receiveData.appendData(data)
    }
    
    func fetchServers(completionBlock: ((success: Bool) -> ())?, errorBlock: ((error: NSError!) -> ())?) {
        self.completionBlock = completionBlock
        self.errorBlock = errorBlock
        self.receiveData = NSMutableData()
        let _ = NSURLConnection(request: self.request, delegate: self, startImmediately: true)
    }
}
