//
//  NextAiringEpisode+CoreDataProperties.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/24/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//
//

import Foundation
import CoreData


extension NextAiringEpisode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NextAiringEpisode> {
        return NSFetchRequest<NextAiringEpisode>(entityName: "NextAiringEpisode")
    }

    @NSManaged public var airingAt: Int64
    @NSManaged public var episode: Int64
    @NSManaged public var timeUntilAiring: Int64
    @NSManaged public var media: Media?

}
