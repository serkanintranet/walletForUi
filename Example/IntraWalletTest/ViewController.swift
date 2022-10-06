//
//  ViewController.swift
//  IntraWalletTest
//
//  Created by mahmudfarzali on 10/02/2022.
//  Copyright (c) 2022 mahmudfarzali. All rights reserved.
//

import UIKit
import IntraWalletTest

class ViewController: UIViewController, AppVersionApiProtocol {
    
    var appVersionApi: AppVersionApi?
    var preferences : UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferences = UserDefaults.standard
        
        appVersionApi = AppVersionApi()
        appVersionApi?.delegate = self
        
        self.getAppVersion()
        
    }
    
    func getAppVersion() {
        DispatchQueue.main.async {
            
            self.appVersionApi?.AppVersion()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AppVersionOnSuccess(response: AppVersionResponse?) {
        DispatchQueue.main.async {
            print("Response - \(String(describing: response))")
        }
    }
    
    func AppVersionOnError(msg: String, type: Int) {
        DispatchQueue.main.async {
        }
    }
    
    
}

