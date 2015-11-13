//
//  ViewController.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/1/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DataManager.getTopAppsDataFromFileWithSuccess { (iTunesData) -> Void in
        // Get #1 app name sing SwiftyJSON
        let json = JSON(data: iTunesData)
        if let appName = json["feed"]["entry"][0]["im:name"]["label"].string {
            print("SwiftyJSON: \(appName)")
        }
        //parsing json for arrays
        //1. retrieve list of apps with SwiftyJSON
        if let appArray = json["feed"]["entry"].array {
            //2. create mutable array to hold objects to be created
            var apps = [AppModel]()
            //3. Loop through all items and create a new instnace of AppModel from JSON data
            for appDict in appArray {
                var appName: String? = appDict["im:name"]["label"].string
                var appURL: String? = appDict["im:image"][0]["label"].string
                
                var app = AppModel(name: appName, appStoreURL: appURL)
                apps.append(app)
            }
            //4. print new objects
            print(apps)
        }
    }
  }
}

