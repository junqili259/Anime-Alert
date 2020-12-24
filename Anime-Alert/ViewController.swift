//
//  ViewController.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/12/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var animeTableView: UITableView!
    var model = Network()
    var animes = [Animes]()// For tableview data
    
    // Reference to managed object context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getSeasonalAnime()
        
        animeTableView.delegate = self
        animeTableView.dataSource = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        animeTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addToWatchList = UIContextualAction(style: .normal, title: "Watch") { (action, view, completionHandler) in
            
            // Get the cell at this indexpath
            let cell = self.animeTableView.cellForRow(at: indexPath) as! AnimeCell
            
            // Get the cell properties
            let animeTitle = cell.animeTitle.text!
            let animeCoverImage = cell.animeCoverImage.image!
            
            // Get other properties from anime api array
            let anime = self.animes[indexPath.row]
            let id = anime.id!
            
            // Convert animeCoverImage to data
            let imageData = animeCoverImage.pngData()!
            
            // Create Core Data Object
            let media = Media(context: self.context)
            media.title = animeTitle
            media.coverImage = imageData
            media.id = Int64(id)
            
            // If properties are aren't nil we set to model else do nothing
            //MARK: Edge case possible: No airing time yet
            if let properties = anime.nextAiringEpisode {
                media.airingAt = Int64(properties.airingAt!)
                media.timeUntilAiring = Int64(properties.timeUntilAiring!)
                media.episode = Int64(properties.episode!)
            }
            
            
            let watchList = WatchList(context: self.context)
            watchList.addToMedia(media)
        
            // Save to Core Data
            do {
                try self.context.save()
                print("data saved")
            } catch{
                print("Save to Core Data failed")
            }
        }
        return UISwipeActionsConfiguration(actions: [addToWatchList])
    }
    
    /*
     "Lower than iOS 13 the delete swipe option will show up as a trailing swipe action by default". To prevent from happening this method is added
     Source: https://programmingwithswift.com/uitableviewcell-swipe-actions-with-swift
     */
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}


extension ViewController: AnimeModelProtocol {
    func animeRetrieved(_ anime: [Animes]) {
                
        self.animes = anime
        animeTableView.reloadData()
    }
}
