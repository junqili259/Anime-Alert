//
//  Network.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/16/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import Foundation


protocol AnimeModelProtocol {
    func animeRetrieved(_ anime: [Animes])
}

class Network {
    
    var delegate: AnimeModelProtocol?

    
    func getSeasonalAnime() {
        
        let urlString = "https://anime-alert-serverless.vercel.app/api/currentSeason"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("url object creation error")
            return
        }
        
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    
                    let media = try decoder.decode(Info.self, from: data!)
                    let animes = media.media!
                    
                    DispatchQueue.main.async {
                        self.delegate?.animeRetrieved(animes)
                    }
                } catch  {
                    print("Error parsing json")
                }
            }
        }
        datatask.resume()
    }
}
