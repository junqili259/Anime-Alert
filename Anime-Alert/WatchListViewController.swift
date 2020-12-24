//
//  WatchListViewController.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/24/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit
import CoreData

class WatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var watchListTableView: UITableView!
    var anime:[Media]?
    
    // Reference to managed object context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchListTableView.delegate = self
        watchListTableView.dataSource = self
        
        fetchAnime()
    }
    
    func fetchAnime() {
        
        // Fetch the data from Core Data to display in the tableview
        do {
            self.anime = try context.fetch(Media.fetchRequest())
            print("Data fetched")
            DispatchQueue.main.async {
                self.watchListTableView.reloadData()
            }
        }
        catch {
            print("Failed to fetch data")
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anime?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        let media = self.anime![indexPath.row]
        cell.displayAnime(media: media)
        return cell
    }
    
    
    // Delete swipe action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Delete anime
            let animeToRemove = self.anime![indexPath.row]
            self.context.delete(animeToRemove)
            
            // Save data
            do {
                try self.context.save()
            } catch {
                print("Failed to save")
            }
            
            // Refetch
            self.fetchAnime()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
