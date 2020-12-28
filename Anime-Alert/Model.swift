//
//  Model.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/16/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import Foundation


struct AnimeData: Decodable {
    var data: AnimePage?
}


struct AnimePage: Decodable {
    var Page: Info?
}


struct Info: Decodable {
    var pageInfo: AnimePageInfo?
    var media: [Animes]?
}

struct AnimePageInfo: Decodable {
    var total: Int?
    var perPage: Int?
    var currentPage: Int?
    var lastPage: Int?
    var hasNextPage: Bool?
}


struct Animes: Decodable {
    var id: Int?
    var title: Title?
    var coverImage: CoverImage?
    var episode: Int?
    var status: String?
    var nextAiringEpisode: AiringStatus?
}


struct Title: Decodable {
    var romaji: String?
    var english: String?
}


struct CoverImage: Decodable {
    var medium: String?
    var large: String?
    var extraLarge: String?
}


struct AiringStatus: Decodable {
    var airingAt: Int?
    var timeUntilAiring: Int?
    var episode: Int?
}

// For statusUpdate
struct StatusUpdate: Decodable {
    var data: AnimeMedia?
}

struct AnimeMedia: Decodable {
    var Media: AnimeMediaContent?
}


struct AnimeMediaContent: Decodable {
    var status: String?
    var episodes: Int?
    var title: Title?
    var nextAiringEpisode: AiringStatus?
}
