//
//  CryptoMPApp.swift
//  Shared
//
//  Created by chlee on 2022/04/26.
//

import SwiftUI

@main
struct CryptoMPApp: App {
    // MARK: Linking App Delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// MARK: Setting Up Menu Bar Icon and Menu Bar Popover area
#if os(macOS)
class AppDelegate: NSObject, ObservableObject, NSApplicationDelegate {
    // MARK: Properties
    @Published var statusItem: NSStatusItem?
    @Published var popover = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMacMenu()
    }
    

    fileprivate func setupMacMenu() {
        // MARK: Popover properties
        popover.animates = true
        popover.behavior = .transient
        
        // MARK: Linking SwiftUI View
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: Home())
        
        // MARK: Making it as Key Window
        popover.contentViewController?.view.window?.makeKey()
        
        // MARK: Setting Menu bar Icon and Action
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let menuButton = statusItem?.button {
            menuButton.image = .init(systemSymbolName: "dollarsign.circle.fill", accessibilityDescription: nil )
            menuButton.action = #selector(menuButtonAction(sender:))
        }
    }
    
    @objc func menuButtonAction(sender: AnyObject) {
        // MARK: Showing/Closing Popover
        if popover.isShown {
            popover.performClose(sender)
            
        } else {
            if let menuButton = statusItem?.button {
                popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
            }
        }
        
    }
}
#endif
