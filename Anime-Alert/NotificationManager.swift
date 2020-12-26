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
    
}
