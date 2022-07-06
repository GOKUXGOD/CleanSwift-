//
//  SearchImageWorker.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import Foundation
import UIKit

protocol ImageFetcher {
    func fetchImage(with imagePath: String,completion: @escaping ((UIImage?, Error?) -> ()))
}

struct ImageEndPoint: Endpoint {
    var httpMethod: HTTPMethod
    var dataType: DataType
    var url: URL
}

class DefaultImageFetcher: ImageFetcher {
    private var imageClient: SearchImageClient

    init(imageClient: SearchImageClient) {
        self.imageClient = imageClient
    }
    func fetchImage(with imagePath: String,completion: @escaping ((UIImage?, Error?) -> ())) {
        if let url = URL(string: imagePath) {
            let endpoint = ImageEndPoint(httpMethod: .get, dataType: .Data, url: url)
            imageClient.getImage(endpoint: endpoint) { result in
                switch result {
                case .success(let data):
                let image = UIImage(data: data!)
                    completion(image, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else {
            completion(nil, APIError.requestFailed)
        }
    }
}
