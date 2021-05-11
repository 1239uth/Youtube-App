//
//  YoutubeApp.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI
import GoogleSignIn

@main
struct YoutubeApp: App {
    
    let signInManager = GoogleSignInManager()
    
    init() {
        GIDSignIn.sharedInstance().clientID = Constants.GID_SIGN_IN_ID
        GIDSignIn.sharedInstance().delegate = signInManager
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(signInManager)
        }
    }
}
