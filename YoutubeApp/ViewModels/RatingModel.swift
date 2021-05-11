//
//  RatingModel.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import Foundation
import Alamofire

class RatingModel: ObservableObject {
    
    var video: Video
    var accessToken: String
    
    @Published var isLiked = false
    @Published var isSubscribed = false
    
    init(video: Video, accessToken: String) {
        
        self.video = video
        self.accessToken = accessToken
        
        getRating()
        
    }
    
}

extension RatingModel {
    
    /// Gets the current users rating for the video
    func getRating() {
        AF.requestYoutube(relativeUrl: "videos/getRating",
                          method: .get,
                          parameters: ["id": video.videoId, "key": Constants.API_KEY],accessToken: accessToken)
        { response in
            if let json = response.value as? [String: Any],
                let items = json["items"] as? [[String: String]],
                let rating = items.first?["rating"] {
                DispatchQueue.main.async {
                    self.isLiked = rating == "like"
                }
            } else {
                print("Could not get rating")
            }
        }
    }
    
    /// Changes the current users rating for the video
    func toggleLike() {
        
        let rating = isLiked ? "none" : "like"
        
        AF.requestYoutube(relativeUrl: "videos/rate",
                          method: .post,
                          parameters: ["id": video.videoId, "rating": rating, "key": Constants.API_KEY],
                          accessToken: accessToken)
        { response in
            DispatchQueue.main.async {
                self.isLiked.toggle()
            }
        }
        
    }
    
}
