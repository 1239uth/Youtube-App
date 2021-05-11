//
//  LikeAndSubscribe.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import SwiftUI

struct LikeAndSubscribe: View {
    
    @ObservedObject var ratingModel: RatingModel
    
    init(video: Video, accessToken: String) {
        self.ratingModel = RatingModel(video: video, accessToken: accessToken)
    }
    
    var likeText: String {
        return ratingModel.isLiked ? "Unlike" : "Like"
    }
    
    var subscribedText: String {
        return ratingModel.isSubscribed ? "Unsubscribe" : "Subscribe"
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                ratingModel.toggleLike()
            }) {
                HStack {
                    Text(likeText)
                    Image(systemName: ratingModel.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                }
                .foregroundColor(ratingModel.isLiked ? .blue : .gray)
            }
            Spacer()
            Button(action: {
                ratingModel.toggleSubscribe()
            }) {
                Text(subscribedText)
                    .bold()
                    .foregroundColor(ratingModel.isSubscribed ? .gray : .red)
                    .padding()
                    .cornerRadius(6)
            }
            Spacer()
        }
    }
}

struct LikeAndSubscribe_Previews: PreviewProvider {
    static var previews: some View {
        LikeAndSubscribe(video: Video(), accessToken: "")
    }
}
