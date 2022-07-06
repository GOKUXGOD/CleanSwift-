//
//  DetailModels.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
 

import UIKit

enum Detail {
  enum RailDetails {
    struct Request {}
    struct Response {
        var data: Item
        var image: UIImage?
    }
    struct ViewModel {
        var title: String
        var country: String
        var artistName: String
        var type: String
        var previewUrl: String?
        var image: UIImage?
        
        init(item: Item, image: UIImage?) {
            title = item.trackName ?? item.collectionName ?? ""
            country = item.country ?? "N.A"
            artistName = item.artistName ?? ""
            type = item.kind ?? ""
            previewUrl = item.previewUrl
            self.image = image
        }
    }
  }
}
