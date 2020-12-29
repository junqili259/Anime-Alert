//
//  NotificationManager.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/26/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init (){}
    
    var center = UNUserNotificationCenter.current()
    var delegate: UNUserNotificationCenterDelegate?
    
    
    func createNotification(title: String, episode: Int, timeUntilAiring: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Episode \(episode) now airing"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeUntilAiring), repeats: false)
        
        let identifier = "\(title)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        NotificationManager.shared.center.add(request) { (error) in
            if error != nil {
                print("Notification request error")
            }
        }
    }
    
    func removeNotifications(title: String) {
        center.removePendingNotificationRequests(withIdentifiers: [title])
    }
    
    
    // Check if identifier exists
    // Create a new notification if the previous notification was delievered
    func pendingNotifications(identifier: String, id: Int64, anime: Media) {
        center.getPendingNotificationRequests { (notifications) in

            let result = notifications.filter {$0.identifier == identifier}
            if !(result.count > 0) {
                self.statusUpdate(id: id, title: identifier, anime: anime)
            }
        }
    }
    
    
    private func statusUpdate(id: Int64, title: String, anime: Media){
        
        let urlString = "https://evening-falls-53193.herokuapp.com/statusUpdate?id=\(id)"
        
        let url = URL(string: urlString)
        
        guard url != nil else{
            print("url object creation error")
            return
        }
        
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    let mydata = try decoder.decode(StatusUpdate.self, from: data!)
                    let media = mydata.data!.Media!
                    let status = media.status!
                    
                    // If media.nextAiringEpisode isn't nil
                    if let properties = media.nextAiringEpisode {
                        let episode = properties.episode!
                        let timeUntilAiring = properties.timeUntilAiring!
                        
                        // Update Core Data properties
                        anime.episode = Int64(episode)
                        anime.airingAt = Int64(media.nextAiringEpisode!.airingAt!)
                        anime.status = status
                        
                        if status == "RELEASING" {
                            self.createNotification(
                                title: title,
                                episode: episode,
                                timeUntilAiring: timeUntilAiring
                            )
                        }
                    }
                } catch  {
                    print("Error parsing json")
                }
            }
        }
        datatask.resume()
    }// end statusUpdate
}
