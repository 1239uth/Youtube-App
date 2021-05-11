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
    var subscriptionId: String?
    
    @Published var isLiked = false
    @Published var isSubscribed = false
    
    init(video: Video, accessToken: String) {
        
        self.video = video
        self.accessToken = accessToken
        
        getRating()
        getSubscriptionStatus()
        
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

extension RatingModel {
    
    /// Gets the current user's subscription status for the channel.
    func getSubscriptionStatus() {
        AF.requestYoutube(relativeUrl: "subscriptions",
                          method: .get,
                          parameters: ["part": "id", "forChannelId": Constants.CHANNEL_ID, "mine": true, "key": Constants.API_KEY],
                          accessToken: accessToken)
        { response in
            if let json = response.value as? [String: Any],
               let items = json["items"] as? [Any] {
                if let item = items.first as? [String: String],
                   let id = item["id"] {
                    self.subscriptionId = id
                }
                
                DispatchQueue.main.async {
                    self.isSubscribed = !items.isEmpty
                }
            }
        }
    }
    
    /// Changes the users subscription status for the channel
    func toggleSubscribe() {
        if isSubscribed {
            self.unsubscribe()
        } else {
            self.subscribe()
        }
    }
    
    /// Subscribes user from channel
    func subscribe() {
        
        let body: [String: Any] = [
            "snippet": [
                "resourceId": [
                    "channelId": Constants.CHANNEL_ID,
                    "kind": "youtube#channel"
                ]
            ]
        ]
        
        AF.requestYoutube(relativeUrl: "subscriptions?part=snippet&key=\(Constants.API_KEY)",
                          method: .post,
                          json: true,
                          parameters: body,
                          accessToken: accessToken)
        { response in
            if let json = response.value as? [String: Any],
               let id = json["id"] as? String {
                self.subscriptionId = id
                
                DispatchQueue.main.async {
                    self.isSubscribed = true
                }
            } else {
                print("Could not subscribe")
            }
        }
        
    }
    
    /// Unsubscribes user from channel
    func unsubscribe() {
        
        guard let subscriptionId = subscriptionId else {
            print("Error: Tried to unsubscribe with no subscription ID.")
            return
        }
        
        AF.requestYoutube(relativeUrl: "subscriptions",
                          method: .delete,
                          parameters: ["id": subscriptionId, "key": Constants.API_KEY],
                          accessToken: accessToken)
        { response in
            self.subscriptionId = nil
            
            DispatchQueue.main.async {
                self.isSubscribed = false
            }
        }
        
    }
}
