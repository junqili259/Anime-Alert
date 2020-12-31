//
//  WLTableExt.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/30/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import Foundation
import UIKit


extension WatchListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anime?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        let media = self.anime![indexPath.row]
        cell.displayAnime(media: media)
        
        // Save any new data from statusUpdate
        do {
            try self.context.save()
        } catch  {
            print("failed to save")
        }
        return cell
    }// end cellForRowAt
    
    
    
    // Delete swipe action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Remove the pending notification
            let cell = self.watchListTableView.cellForRow(at: indexPath) as! WatchListCell
            let title = cell.animeTitle.text!
            NotificationManager.shared.removeNotifications(title: title)
            
            // Delete anime
            let animeToRemove = self.anime![indexPath.row]
            self.context.delete(animeToRemove)
            
            // Save data
            do {
                try self.context.save()
            } catch {
                print("Failed to save")
            }
            completionHandler(true)
            
            // Refetch
            self.fetchAnime()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }// end trailingSwipeActionsConfigurationForRowAt
    
    
    
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        self.setEditing(true, animated: true)
    }
    
    
}
