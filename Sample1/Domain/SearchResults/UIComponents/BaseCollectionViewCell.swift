//
//  BaseCollectionViewCell.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()

    var loader: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 0

        return label
    }()
    private var imageFetcher: ImageFetcher?
    private var viewModel: RailItem?
    private var imageLoadTask: DispatchWorkItem? {
        willSet {
            imageLoadTask?.cancel()
        }
    }
    
    func updateWith(viewModel: RailItem, imageFetcher: ImageFetcher) {
        loader.startAnimating()
        label.text = viewModel.title
        self.viewModel = viewModel
        self.imageFetcher = imageFetcher
        updateImage()
    }

    private func updateImage() {
        guard let viewModel = viewModel, let _ = imageFetcher else { return }
        imageView.image = UIImage(named: "ic_placeholder")
        let imagePath = viewModel.previewUrl
        let task = DispatchWorkItem { [weak self] in
            self?.imageFetcher?.fetchImage(with: imagePath, completion: { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let viewModel = self.viewModel else { return }
                    guard viewModel.previewUrl == imagePath else { return }
                    if let image = image {
                        self.imageView.image = image
                        self.viewModel?.image = image
                    } else {

                    }
                    self.imageLoadTask = nil
                    self.loader.stopAnimating()
                }
            })
        }
        imageLoadTask = task
        DispatchQueue.global(qos: .userInteractive).async(execute: task)
    }
}
