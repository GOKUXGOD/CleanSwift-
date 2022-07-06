//
//  SearchResultsModels.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
 

import UIKit

enum SearchResults {
    enum SearchItems {
        struct Request {}
        struct Response {
            var searchData: [SearchData]
        }
        struct ViewModel {
            var railItems: [Rail]
        }
    }
}

public enum RailType: String {
    case album = "Album"
    case artist = "Artist"
    case book = "Book"
    case movie = "Movie"
    case musicVideo = "MusicVideo"
    case podcast = "Podcast"
    case song = "Song"
    
    init(fromRawValue: String) {
        self = RailType(rawValue: fromRawValue) ?? .album
    }
}
enum WrapperType: String {
    case track = "track"
    case collection = "collection"
    case artist = "artist"
    case audiobook = "audiobook"
}
public protocol Rail {
    var type: RailType {get}
    var railItems: [RailItem] {get set}
}

public protocol RailItem {
    var kind: String {get}
    var previewUrl: String {get}
    var title: String {get}
    var image: UIImage? { get set }
}

struct iTunesRail: Rail {
    var type: RailType
    var railItems: [RailItem]
}

extension iTunesRail {
    init(searchData: SearchData) {
        let kind = RailType(fromRawValue: searchData.type ?? "")
        type = kind
        let rails: [RailItem] = searchData.results.compactMap({ result in
            if let wrapperType = result.wrapperType {
                if wrapperType == WrapperType.collection.rawValue {
                    if result.collectionName != nil {
                        return iTunesRailItems(image: nil, kind: kind.rawValue, previewUrl: result.artworkUrl100 ?? "", title: result.collectionName!)
                    }
                } else if wrapperType == WrapperType.track.rawValue {
                    if result.artworkUrl100 != nil && result.trackName != nil {
                        return iTunesRailItems(image: nil, kind: kind.rawValue, previewUrl: result.artworkUrl100!, title: result.trackName!)
                    }
                } else if wrapperType == WrapperType.artist.rawValue {
                    if result.artistName != nil {
                        return iTunesRailItems(image: nil, kind: kind.rawValue, previewUrl: result.artworkUrl100 ?? "", title: result.artistName!)
                    }
                } else if wrapperType == WrapperType.audiobook.rawValue {
                    if result.artworkUrl100 != nil && result.collectionName != nil {
                        return iTunesRailItems(image: nil, kind: kind.rawValue, previewUrl: result.artworkUrl100!, title: result.collectionName!)
                    }
                }
            }
            return nil
        })
        railItems = rails
    }
}

class iTunesRailItems: RailItem {
    var image: UIImage?
    var kind: String
    var previewUrl: String
    var title: String
    
    init(image: UIImage?, kind: String, previewUrl: String, title: String) {
        self.image = image
        self.kind = kind
        self.previewUrl = previewUrl
        self.title = title
    }
}
