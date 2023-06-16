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
    
    public init(artistID: Int?, collectionID: Int?, trackID: Int?, wrapperType: String?, kind: String?, artistName: String?, collectionName: String?, trackName: String?, collectionCensoredName: String?, trackCensoredName: String?, artistViewURL: String?, collectionViewURL: String?, trackViewURL: String?, previewURL: String?, artworkUrl30: String?, artworkUrl60: String?, artworkUrl100: String?, collectionPrice: Double?, trackPrice: Double?, releaseDate: Date?, collectionExplicitness: String?, trackExplicitness: String?, discCount: Int?, discNumber: Int?, trackCount: Int?, trackNumber: Int?, trackTimeMillis: Int?, country: String?, currency: String?, primaryGenreName: String?, isStreamable: Bool?) {
        self.artistID = artistID
        self.collectionID = collectionID
        self.trackID = trackID
        self.wrapperType = wrapperType
        self.kind = kind
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.collectionCensoredName = collectionCensoredName
        self.trackCensoredName = trackCensoredName
        self.artistViewURL = artistViewURL
        self.collectionViewURL = collectionViewURL
        self.trackViewURL = trackViewURL
        self.previewURL = previewURL
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.collectionExplicitness = collectionExplicitness
        self.trackExplicitness = trackExplicitness
        self.discCount = discCount
        self.discNumber = discNumber
        self.trackCount = trackCount
        self.trackNumber = trackNumber
        self.trackTimeMillis = trackTimeMillis
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.isStreamable = isStreamable
    }
}
