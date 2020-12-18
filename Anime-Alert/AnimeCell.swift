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
        animeTitle.text = anime.title!.romaji!
        
        //let image = anime.coverImage!.large!
        let image = anime.coverImage!.medium!
        
        let url = URL(string: image)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                DispatchQueue.main.async {
                    self.animeCoverImage.image = UIImage(data: data!)
                    
                }
            }
        }
        session.resume()
    }
    
}
