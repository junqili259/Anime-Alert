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
        
        // Customizing the cell
        let cell = animeTableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
        let anime = animes[indexPath.row]
        cell.displayAnime(anime: anime)
        
        return cell
    }
}


extension ViewController: AnimeModelProtocol {
    func animeRetrieved(_ anime: [Animes]) {
                
        self.animes = anime
        animeTableView.reloadData()
    }
}
