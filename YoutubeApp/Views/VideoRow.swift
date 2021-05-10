//
//  VideoRow.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var videoPreview: VideoPreview
    @State private var isPresenting = false
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
        Button(action: {
            isPresenting = true
        }) {
            VStack (alignment: .leading, spacing: 10) {
                // Thumbnail image
                GeometryReader { geo in
                    Image(uiImage: UIImage(data: videoPreview.thumbnailData) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.width*9/16)
                        .clipped()
                        .onAppear {
                            imageHeight = geo.size.width*9/16
                        }
                }
                .frame(height: imageHeight)
                
                // Video title
                Text(videoPreview.title)
                    .bold()
                
                // Video date
                Text(videoPreview.date)
                    .foregroundColor(.gray)
            }
            .font(.system(size: 19))
        }
        .sheet(isPresented: $isPresenting, content: {
            VideoDetail(video: videoPreview.video)
        })
    }
}

struct VideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VideoRow(videoPreview: VideoPreview(video: Video()))
    }
}
