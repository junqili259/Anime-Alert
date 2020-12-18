//
//  Network.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/16/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import Foundation


protocol AnimeModelProtocol {
    func animeRetrieved(_ anime: AnimePage)
}

class Network {
    
    var delegate: AnimeModelProtocol?

    func getSeasonalAnime(page: Int = 1) {
        
        // Temporarily using api on local server
        let urlString = "http://localhost:8000/?page=\(page)"
        
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
                    
                    let animes = try decoder.decode(AnimeData.self, from: data!)
                    let animeData = animes.data!
                    
                    // Pass data back to view by main thread
                    DispatchQueue.main.async {
                        self.delegate?.animeRetrieved(animeData)
                    }
                    
                } catch  {
                    print("Error parsing json")
                }
            }
        }
        datatask.resume()
    }
}
