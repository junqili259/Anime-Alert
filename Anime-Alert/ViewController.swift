//
//  ViewController.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/12/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var animeTableView: UITableView!
    var model = Network()
    var animes = [Animes]()
    var nextPage: Bool?
    var currentPage: Int?
    var prevPage: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getSeasonalAnime()
        
        animeTableView.delegate = self
        animeTableView.dataSource = self
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = animeTableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
        let anime = animes[indexPath.row]
        cell.displayAnime(anime: anime)
        
        
        // Load next page of seasonal animes
        if indexPath.row == self.animes.count - 1 {
            
            let page = currentPage!
            
            if nextPage! == true {
                model.getSeasonalAnime(page: page + 1)
            }
        }
        
        // Load previous page of seasonal animes
        if indexPath.row == 0 && currentPage! > 1 {
            
            let page = currentPage!
            model.getSeasonalAnime(page: page - 1)
        }
         
        return cell
    }
}


extension ViewController: AnimeModelProtocol {
    func animeRetrieved(_ anime: AnimePage) {
        
        /*
         Data on seasonal animes on the current page and page information such as
         if next page exists.
         */
        
        self.animes = anime.Page!.media!
        self.nextPage = anime.Page!.pageInfo!.hasNextPage!
        self.currentPage = anime.Page!.pageInfo!.currentPage!
        self.prevPage = anime.Page!.pageInfo!.lastPage!
        
        animeTableView.reloadData()
    }
}
