//
//  Home.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI
import GoogleSignIn

let backgroundColour = Color(red: 31/255, green: 33/255, blue: 36/255)

struct Home: View {
    @EnvironmentObject var signInManager: GoogleSignInManager
    @StateObject var model = VideoModel()
    
    var body: some View {
        VStack {
            
            if !signInManager.signedIn {
                GoogleSignInButton()
                    .padding()
                    .frame(height: 60)
                    .transition(.move(edge: .top))
                    .onOpenURL(perform: { url in
                        GIDSignIn.sharedInstance().handle(url)
                    })
            } else {
                HStack {
                    Spacer()
                    Button(action: {
                        GIDSignIn.sharedInstance().signOut()
                        signInManager.signedIn = false
                    }) {
                        Text("Sign Out")
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 30)
                    .transition(.move(edge: .top))
                }
                
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(model.videos, id: \.videoId) { video in
                        VideoRow(videoPreview: VideoPreview(video: video))
                            .padding()
                    }
                }
                .padding(.top, 20)
            }
        }
        .foregroundColor(.white)
        .background(backgroundColour.edgesIgnoringSafeArea(.all))
        .animation(.easeOut)
        .onAppear {
            GIDSignIn.sharedInstance().restorePreviousSignIn()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(GoogleSignInManager())
    }
}
