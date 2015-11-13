//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation

let TopAppURL = "https://itunes.apple.com/us/rss/topgrossingipadapplications/limit=25/json"

class DataManager {
  
  class func getTopAppsDataFromFileWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
    //1. takes URL and completion closure that passes in NSData object
    loadDataFromURL(NSURL(string: TopAppURL)!, completion: {(data, error) -> Void in
        //2 check if data exists using optional binding
        if let urlData = data {
            //3 pass data to success closure
            success(iTunesData: urlData)
        }
    })
  }
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    
    // Use NSURLSession to get data from an NSURL
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }
}