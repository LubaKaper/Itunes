//
//  PodcastCell.swift
//  ITunes
//
//  Created by Liubov Kaper  on 12/8/20.
//

import UIKit
import Kingfisher

class PodcastCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var podcastImage: UIImageView!
    
    public func configureCell(for podcast: Podcast) {
        
        collectionNameLabel.text = podcast.collectionName
        
        podcastImage.kf.setImage(with: URL(string: podcast.artworkUrl600))
    }
    
}
