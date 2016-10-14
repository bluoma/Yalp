//
//  JsonDownloader.swift
//  Yalp
//
//  Created by Bill on 10/3/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import Foundation

protocol JsonDownloaderDelegate: class {
    
    func jsonDownloaderDidFinish(downloader: JsonDownloader, json: [String:AnyObject]?, response: HTTPURLResponse, error: NSError?)
    
}

class JsonDownloader {
    
    private static var opq: OperationQueue = JsonDownloader.createOperationQueue()
    
    private static func createOperationQueue() -> OperationQueue {
        let opq = OperationQueue()
        opq.name = "com.yalp.netopq"
        opq.maxConcurrentOperationCount = 1
        dlog("opq: \(opq)")
        return opq
    }
    
    var session: URLSession! = nil
    weak var delegate: JsonDownloaderDelegate? = nil
    
    init() {
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 15
        urlconfig.timeoutIntervalForResource = 15
        
        self.session = URLSession(configuration: urlconfig, delegate: nil, delegateQueue: JsonDownloader.opq)
    }
    
    func doAuthToken() ->  URLSessionDataTask? {
        
        var dataTask: URLSessionDataTask? = nil
        
        guard let authUrl = URL(string: yelpOauth2Endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: authUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.httpMethod = "POST"
        request.httpBody = yelpOauth2PostBody.data(using: .utf8, allowLossyConversion: false)
        
        dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            var returnedError: NSError? = nil
            var json: [String:AnyObject]? = nil
            var statusCode: Int = 0;
            var contentType: String = ""
            var httpResp: HTTPURLResponse! = HTTPURLResponse(url: authUrl, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
            
            
            if (response != nil) {
                httpResp = response as! HTTPURLResponse
                
                if (httpResp.allHeaderFields["Content-Type"] != nil) {
                    contentType = httpResp.allHeaderFields["Content-Type"] as! String
                }
                statusCode = httpResp.statusCode
                dlog("responseUrl: \(httpResp.url)")
                dlog("responseCode: \(statusCode)")
                
                for (hkey, hval) in httpResp.allHeaderFields {
                    
                    let skey: String = hkey as! String
                    let sval: String = hval as! String
                    
                    dlog("header: \(skey)::\(sval)")
                }
            }
            
            if error != nil {
                dlog("error: \(error)")
                returnedError = error as? NSError
            }
            else if data != nil {
                if (contentType.contains("json")) {
                    do {
                        // Convert NSData to Dictionary where keys are of type String, and values are of any type
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
                        dlog("json: \(json)")
                    }
                    catch let jerr as NSError {
                        dlog("json Error: \(jerr)")
                        returnedError = jerr
                    }
                }
                else {
                    let errString = "contentType is not json: \(contentType)"
                    dlog(errString)
                    let err: NSError = NSError(domain: "mooveeze", code: -400, userInfo: nil)
                    returnedError = err
                }
            }
            else {
                dlog("both data and error are nil")
                returnedError = nil
            }
            
            DispatchQueue.main.async {
                self.delegate?.jsonDownloaderDidFinish(downloader: self, json: json, response: httpResp, error: returnedError)
            }
            dlog("out closure on thread: \(Thread.current)")
        })
        
        dataTask?.resume()
        
        return dataTask
    }
    
    func doDownload(urlString: String) -> URLSessionDataTask?
    {
        print("urlString: \(urlString)")
        dlog("do we have an auth token: \(yelpCurrentAuthToken), char count: \(yelpCurrentAuthToken.characters.count)")
        
        if yelpCurrentAuthToken.isEmpty {
            dlog("we never got an auth token, oh well")
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            dlog("bad url: \(urlString)")
            return nil
        }
        
        dlog("in url: \(urlString)")
        var request = URLRequest(url: url)
        request.setValue(yelpAuthBearerHeaderVal, forHTTPHeaderField: yelpAuthBearerHeaderKey)
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
        
            var returnedError: NSError? = nil
            var json: [String:AnyObject]? = nil
            var statusCode: Int = 0;
            var contentType: String = ""
            var httpResp: HTTPURLResponse! = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
            
            
            if (response != nil) {
                httpResp = response as! HTTPURLResponse
                
                if (httpResp.allHeaderFields["Content-Type"] != nil) {
                    contentType = httpResp.allHeaderFields["Content-Type"] as! String
                }
                statusCode = httpResp.statusCode
                dlog("responseUrl: \(httpResp.url)")
                dlog("responseCode: \(statusCode)")
                
                for (hkey, hval) in httpResp.allHeaderFields {
                    
                    let skey: String = hkey as! String
                    let sval: String = hval as! String

                    dlog("header: \(skey)::\(sval)")
                }
            }
            
            if error != nil {
                dlog("error: \(error)")
                returnedError = error as? NSError
            }
            else if data != nil {
                if (contentType.contains("json")) {
                    do {
                        // Convert NSData to Dictionary where keys are of type String, and values are of any type
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
                        
                    }
                    catch let jerr as NSError {
                        dlog("json Error: \(jerr)")
                        returnedError = jerr
                    }
                }
                else {
                    let errString = "contentType is not json: \(contentType)"
                    dlog(errString)
                    let err: NSError = NSError(domain: "mooveeze", code: -400, userInfo: nil)
                    returnedError = err
                }
            }
            else {
                dlog("both data and error are nil")
                returnedError = nil
            }
            
            DispatchQueue.main.async {
                self.delegate?.jsonDownloaderDidFinish(downloader: self, json: json, response: httpResp, error: returnedError)
            }
            dlog("out closure on thread: \(Thread.current)")

        })
        
        dataTask.resume()
        
        return dataTask
        
    }
    
    
}
