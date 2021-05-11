//
//  GIDSignInManager.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import Foundation
import GoogleSignIn

class GoogleSignInManager: NSObject, GIDSignInDelegate, ObservableObject {
    
    @Published var signedIn = false
    var accessToken = ""
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        self.accessToken = user.authentication.accessToken
        
        signedIn = true
    }

}
