//
//  VideoDetail.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI

struct VideoDetail: View {
    var video: Video
    
    var date: String {
        // Create a formatted date from the video's date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: video.published)
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            // Video title
            Text(video.title)
                .bold()
            
            // Date
            Text(date)
                .foregroundColor(.gray)
            
            // Display video
            YoutubeVideoPlayer(video: video)
                .aspectRatio(CGSize(width: 1280, height: 720), contentMode: .fit)
            
            // Video description
            ScrollView {
                Text(video.description)
            }
        }
        .font(.system(size: 19))
        .padding()
        .padding(.top, 40)
    }
}

struct VideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoDetail(video: Video())
            VideoDetail(video: Video())
                .colorScheme(.dark)
        }
    }
}
