//
//  Home.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI

let backgroundColour = Color(red: 31/255, green: 33/255, blue: 36/255)

struct Home: View {
    @StateObject var model = VideoModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.videos, id: \.videoId) { video in
                    VideoRow(videoPreview: VideoPreview(video: video))
                        .padding()
                }
            }
            .padding(.top, 20)
        }
        .foregroundColor(.white)
        .background(backgroundColour.edgesIgnoringSafeArea(.all))
        .animation(.easeOut)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
