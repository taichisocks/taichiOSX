//
//  AppDelegate.swift
//  taichiOSX
//
//  Created by taichi on 15/4/20.
//  Copyright (c) 2015 taichi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBOutlet weak var menu: NSMenu!
    
    @IBAction func exitClick(sender: AnyObject)
    {
        NSApplication.sharedApplication().terminate(self)
    }
    
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1) // NSVariableStatusItemLength
        statusItem.toolTip = "taichi"
        statusItem.image = NSImage(named: "Status")
        statusItem.menu = menu
        
        if SettingsModel.sharedInstance.remoteHost.isEmpty {
            let alert = NSAlert()
            alert.messageText = "Please set your config first!"
            alert.runModal()
            return
        }
        
        let remoteHost = SettingsModel.sharedInstance.remoteHost
        var c_remote_host = remoteHost.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let remotePort = SettingsModel.sharedInstance.remotePort
        var c_remote_port = CInt(0)
        if let rPort = remotePort.toInt() {
            c_remote_port = CInt(rPort)
        }
        //        var c_remote_port = remotePort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let method = SettingsModel.sharedInstance.method
        var c_method = method.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let password = SettingsModel.sharedInstance.password
        var c_password = password.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let localHost = SettingsModel.sharedInstance.localHost
        var c_local_host = localHost.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let localPort = SettingsModel.sharedInstance.localPort
        var c_local_port = CInt(0)
        if let lPort = localPort.toInt() {
            PacServer.sharedInstance.socks5Port = lPort
            c_local_port = CInt(lPort)
        }
        //        var c_local_port = localPort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        
        startProxyWithConfig(c_remote_host, c_remote_port, c_method, c_password, c_local_host, c_local_port)
        PacServer.sharedInstance.start(listenPort: 8100, error: nil)
    }


    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

