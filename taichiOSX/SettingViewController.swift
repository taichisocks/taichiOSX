//
//  SettingViewController.swift
//  taichiOSX
//
//  Created by taichi on 15/4/20.
//  Copyright (c) 2015 taichi. All rights reserved.
//

import Cocoa

class SettingViewController: NSViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        remoteHostTextField.stringValue = SettingsModel.sharedInstance.remoteHost
        remotePortTextField.stringValue = SettingsModel.sharedInstance.remotePort
        passwordTextField.stringValue = SettingsModel.sharedInstance.password
        localHostTextField.stringValue = SettingsModel.sharedInstance.localHost
        localPortTextField.stringValue = SettingsModel.sharedInstance.localPort
        
        for i in 0..<methodSelector.numberOfItems {
            if methodSelector.itemTitleAtIndex(i) == SettingsModel.sharedInstance.method {
                methodSelector.selectItemAtIndex(i)
                break
            }
        }
    }
    
    @IBOutlet weak var remoteHostTextField: NSTextField!

    @IBOutlet weak var remotePortTextField: NSTextField!

    @IBOutlet weak var methodSelector: NSPopUpButton!

    @IBOutlet weak var passwordTextField: NSTextField!

    @IBOutlet weak var localHostTextField: NSTextField!

    @IBOutlet weak var localPortTextField: NSTextField!


    @IBAction func importConfig(sender: AnyObject)
    {
        alertMsg("Not implement")
    }
    
    @IBAction func export(sender: AnyObject)
    {
        alertMsg("Not implement")
    }
    
    func alertMsg(msg: String)
    {
        let alert = NSAlert()
        alert.messageText = msg
        alert.runModal()
    }
    
    @IBAction func restartProxy(sender: AnyObject)
    {
        let remoteHost = remoteHostTextField.stringValue
        SettingsModel.sharedInstance.remoteHost = remoteHost
        var c_remote_host = remoteHost.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let remotePort = remotePortTextField.integerValue
        SettingsModel.sharedInstance.remotePort = remotePortTextField.stringValue
        var c_remote_port = CInt(remotePort)
//        var c_remote_port = remotePort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let method = methodSelector.titleOfSelectedItem!
        SettingsModel.sharedInstance.method = method
        var c_method = method.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let password = passwordTextField.stringValue
        SettingsModel.sharedInstance.password = password
        var c_password = password.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let localHost = localHostTextField.stringValue
        SettingsModel.sharedInstance.localHost = localHost
        var c_local_host = localHost.cStringUsingEncoding(NSUTF8StringEncoding)!

        let localPort = localPortTextField.integerValue
        SettingsModel.sharedInstance.localPort = localPortTextField.stringValue
        var c_local_port = CInt(localPort)
//        var c_local_port = localPort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        SettingsModel.sharedInstance.saveData()
                
        startProxyWithConfig(c_remote_host, c_remote_port, c_method, c_password, c_local_host, c_local_port)
    }
}
