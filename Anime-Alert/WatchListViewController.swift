//
//  WatchListViewController.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/24/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class WatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var watchListTableView: UITableView!
    var anime:[Media]?
    
    // Reference to managed object context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchListTableView.delegate = self
        watchListTableView.dataSource = self
        
        self.watchListTableView.separatorStyle = .none
        self.watchListTableView.allowsSelection = false
        self.watchListTableView.allowsMultipleSelectionDuringEditing = true
        //self.watchListTableView.allowsMultipleSelection
        
        fetchAnime()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchAnime()
    }
    
    func fetchAnime() {
        
        // Fetch the data from Core Data to display in the tableview
        do {
            self.anime = try context.fetch(Media.fetchRequest())
            
            DispatchQueue.main.async {
                self.watchListTableView.reloadData()
            }
        }
        catch {
            print("Failed to fetch data")
        }
    }
    
    @IBAction func deleteRows(_ sender: Any) {
        let showsToDelete = watchListTableView.indexPathsForSelectedRows
        
        if let indexpaths = showsToDelete {
            for indexpath in indexpaths {
                
                // Remove notifications
                let show = anime![indexpath.row]
                NotificationManager.shared.removeNotifications(title: show.title!)
                
                // Delete anime from Core Data
                self.context.delete(show)
                
                // save data
                do {
                    try self.context.save()
                } catch  {
                    print("Failed to save: Delete Rows")
                }
            }
        }
        self.watchListTableView.isEditing = false
        fetchAnime()
    }
}
