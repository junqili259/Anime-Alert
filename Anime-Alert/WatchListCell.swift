//
//  WatchListCell.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/24/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit

class WatchListCell: UITableViewCell {

    @IBOutlet weak var animeCoverImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var airingDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayAnime(media: Media) {
        
        animeTitle.text = media.title!
        animeCoverImage.image = UIImage(data: media.coverImage!)
        
        #warning("Handle if airing date isn't available ")
        let episode = media.episode
        let airingDate = Date(timeIntervalSince1970: TimeInterval(integerLiteral: media.airingAt))
    
        // Setting the date format to display
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyy HH:mm a"
        dateFormatter.timeZone = .autoupdatingCurrent
        
        let date = dateFormatter.string(from: airingDate)
    
        self.airingDate.text = "Episode \(episode) airing on \(date)"
    }

}
