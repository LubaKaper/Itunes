//
//  PodcastModel.swift
//  ITunes
//
//  Created by Liubov Kaper  on 11/24/20.
//

import Foundation

// we use a struct becouse we passing a copy of the model, not a reference
// no inheritance . immitable by default

struct ResultWrapper: Codable {
    var results: [Podcast]
}

struct Podcast: Codable {
    var collectionName: String
    var artworkUrl100: String
    var artworkUrl600: String
}
