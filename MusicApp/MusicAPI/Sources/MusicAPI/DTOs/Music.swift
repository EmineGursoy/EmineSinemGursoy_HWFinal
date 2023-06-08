//
//  Music.swift
//  
//
//  Created by Emine Sinem on 6.06.2023.
//

import Foundation

public struct MusicResult: Decodable {
    public let resultCount: Int?
    public let results: [Music]?
}

public struct Music: Decodable {
    public let artistID, collectionID, trackID: Int?
    public let wrapperType, kind: String?
    public let artistName, collectionName, trackName, collectionCensoredName: String?
    public let trackCensoredName: String?
    public let artistViewURL, collectionViewURL, trackViewURL: String?
    public let previewURL: String?
    public let artworkUrl30, artworkUrl60, artworkUrl100: String?
    public let collectionPrice, trackPrice: Double?
    public let releaseDate: Date?
    public let collectionExplicitness, trackExplicitness: String?
    public let discCount, discNumber, trackCount, trackNumber: Int?
    public let trackTimeMillis: Int?
    public let country, currency, primaryGenreName: String?
    public let isStreamable: Bool?

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case wrapperType, kind
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
    }
}
