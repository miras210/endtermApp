//
//  Model.swift
//  endtermProject
//
//  Created by Miras Alimov on 25.02.2021.
//

import Foundation

struct ArtistInfo: Codable {
    let artist: ArtistWithBio
}

struct ArtistWithBio: Codable {
    let name: String
    let image: [Image]
    let bio: Bio
}

struct Bio: Codable {
    let published: String
    let summary: String
}

struct ArtistSearch: Codable {
    let results: ArtistResult
}

struct TrackSearch: Codable {
    let results: TrackResult
}

struct TrackResult: Codable {
    enum CodingKeys: String, CodingKey {
        case trackmatches
        case itemNum = "opensearch:itemsPerPage"
    }
    
    let trackmatches: TrackMatches
    let itemNum: String
}

struct ArtistResult: Codable {
    enum CodingKeys: String, CodingKey {
        case artistmatches
        case itemNum = "opensearch:itemsPerPage"
    }
    
    let itemNum: String
    let artistmatches: ArtistMatches
}

struct TrackMatches: Codable {
    let track: [Track]
}

struct Track: Codable, Hashable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    let name: String
    let artist: String
    let image: [Image]
}

struct ArtistMatches: Codable {
    let artist: [Artist]
}

struct Artist: Codable {
    let name: String
    let mbid: String
    let image: [Image]
}

struct Image: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case img = "#text"
        case size
    }
    
    let img: String
    let size: String
}
