//
//  Seeds.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 02/07/22.
//

import Foundation
@testable import Sample1

enum Seeds {
    static let mediaTypes = MediaTypes(medias: ["Album",
                                                "Artist",
                                                "Book",
                                                "Movie",
                                                "MusicVideo",
                                                "Podcast",
                                                "Song"])
    static let searchData = Bundle.main.decode(SearchData.self, from: "MockSearchResponse.json")
}

