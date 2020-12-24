//
//  Media+CoreDataProperties.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/24/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var coverImage: Data?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var nextAiringEpisode: NextAiringEpisode?

}
