//
//  YoutubeVideoPlayer.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI
import WebKit

struct YoutubeVideoPlayer: UIViewRepresentable {
    var video: Video
    
    func makeUIView(context: Context) -> some UIView {
        // Create web view
        let view = WKWebView()
        
        // Create url for the video
        let embedUrlString = Constants.YT_EMBED_URL + video.videoId
        
        // Load video into web view
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        view.load(request)
        
        // Return web view
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct YoutubeVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoPlayer(video: Video())
    }
}
