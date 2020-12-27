//
//  NotificationManager.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/26/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init (){}
    
    var center = UNUserNotificationCenter.current()
    
    
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
    func pendingNotifications(identifier: String, id: Int64) {
        center.getPendingNotificationRequests { (notifications) in
            for notification in notifications {
                if notification.identifier == identifier {
                    return
                }
            }
            
            self.statusUpdate(id: id, title: identifier)
        }
    }
    
    
    private func statusUpdate(id: Int64, title: String){
        
        let urlString = "http://192.168.1.4:80/statusUpdate?id=\(id)"
        
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
                    
                    self.createNotification(
                        title: title,
                        episode: media.nextAiringEpisode!.episode!,
                        timeUntilAiring: media.nextAiringEpisode!.timeUntilAiring!
                    )
                    
                } catch  {
                    print("Error parsing json")
                }
            }
        }
        datatask.resume()
    }
}
