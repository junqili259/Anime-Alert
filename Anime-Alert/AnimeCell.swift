//
//  AnimeCell.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/17/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit

class AnimeCell: UITableViewCell {

    @IBOutlet weak var animeCoverImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    let cache = NSCache<NSNumber, NSData>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


        
    func displayAnime(anime: Animes) {
        
        animeCoverImage.image = nil
        animeTitle.text = nil
        
        
        // Set anime title
        if let englishTitle = anime.title!.english {
            animeTitle.text = englishTitle
        } else {
            animeTitle.text = anime.title!.romaji!
        }
        
        let imageUrl = anime.coverImage!.extraLarge!
        
        // Check cache for image data
        if let cachedImageData = cache.object(forKey: anime.id! as NSNumber) as Data? {
            animeCoverImage.image = UIImage(data: cachedImageData)
            return
        }

        let url = URL(string: imageUrl)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Cache the image data
                self.cache.setObject(data! as NSData, forKey: anime.id! as NSNumber)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.animeCoverImage.image = image
                }
            }
        }
        session.resume()
    } // end displayAnime()
    
}
