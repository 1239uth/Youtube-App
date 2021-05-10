//
//  CacheManager.swift
//  YoutubeApp
//
//  Created by Uthman Mohamed on 2021-05-10.
//

import Foundation

class CacheManager {
    
    static var cache = [String : Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        // Store the image data with url as key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        // Try and get data for specified url
        return cache[url]
    }
}
