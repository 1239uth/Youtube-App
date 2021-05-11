//
//  YoutubeRequest.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-11.
//

import Foundation
import Alamofire

extension Session {
    
    func requestYoutube(
        relativeUrl: String,
        method: HTTPMethod,
        json: Bool = false,
        parameters: Parameters? = nil,
        accessToken: String,
        completion: ((AFDataResponse<Any>) -> Void)? = nil
    ) {
        
        guard let url = URL(string: "\(Constants.API_URL)/\(relativeUrl)") else {
            print("Couldn't get URL for relative path \(relativeUrl)")
            return
        }
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: json ? JSONEncoding.default : URLEncoding.default,
            headers: ["Authorization": "Bearer \(accessToken)", "Accept": "application/json"]
        )
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print("Youtube data API call failed with error: \n\(error.failureReason ?? error.localizedDescription)")
                return
            }
            
            if let completion = completion {
                completion(response)
            }
        }
    }
    
}
