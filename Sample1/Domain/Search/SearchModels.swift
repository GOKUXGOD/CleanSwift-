//
//  SearchModels.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

enum Search {
    // MARK: Use cases
    enum GetMediaTypes {
        struct Request {}
        struct Response {
            var mediaTypesData: MediaTypes
        }
        struct ViewModel {
            var mediaTypes: [String]
        }
    }
    
    enum SearchItems {
        struct Request {
            var mediaTypes: [String]
            var searchTerm: String
    
            func getEntityTypeFor(_ media: String) -> String {
                if media == "Album" {
                    return "album"
                } else if media == "Artist" {
                    return "musicArtist"
                } else if media == "Book" {
                    return "audiobook"
                } else if media == "Movie" {
                    return "movie"
                } else if media == "Music Video" {
                    return "musicVideo"
                } else if media == "Podcast" {
                    return "podcast"
                } else if media == "Song" {
                    return "song"
                }
                return "allTrack"
            }
        }
        struct Response {
            var searchResults: [SearchData]
            var error: Error?
            var errorMsg: String?
        }
        struct ViewModel {
            var mediaTypes: [String]
        }
    }
}
