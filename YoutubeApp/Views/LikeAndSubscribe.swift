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
        return ratingModel.isLiked ? "Unlike" : "Like 👍"
    }
    
    var subscribedText: String {
        return ratingModel.isSubscribed ? "Unsubscribe" : "Subscribe"
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(likeText) {
                ratingModel.toggleLike()
            }
            Spacer()
            Button(subscribedText) {
                ratingModel.isSubscribed.toggle()
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
