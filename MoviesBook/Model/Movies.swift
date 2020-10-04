//
//  Movies.swift
//  MoviesBook
//
//  Created by Semafor on 3.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import Foundation

struct Movies : Codable {
    var page : Int?
    var totalPages : Int?
    var totalResults : Int?
    var results : [MovieResult]?
    
    enum CodingKeys: String, CodingKey {
           case page = "page"
           case totalPages = "total_pages"
           case totalResults = "total_results"
           case results = "results"
    }

   init(from decoder: Decoder) throws {
       let values = try? decoder.container(keyedBy: CodingKeys.self)
       page = try? values?.decodeIfPresent(Int.self, forKey: .page)
       totalPages = try? values?.decodeIfPresent(Int.self, forKey: .totalPages)
       totalResults = try? values?.decodeIfPresent(Int.self, forKey: .totalResults)
       results = try? values?.decodeIfPresent([MovieResult].self, forKey: .results)
   }
}
struct MovieResult : Codable{
    var id : Int64?
    var popularity : Double?
    var voteCount : Int?
    var video : Bool?
    var posterPath : String?
    var backdropPath : String?
    var originalLanguage : String?
    var originalTitle : String?
    var title : String?
    var voteAverage : Double?
    var overview : String?
    var releaseDate : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        popularity = try? values?.decodeIfPresent(Double.self, forKey: .popularity)
        voteCount = try? values?.decodeIfPresent(Int.self, forKey: .voteCount)
        video = try? values?.decodeIfPresent(Bool.self, forKey: .video)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try? values?.decodeIfPresent(String.self, forKey: .backdropPath)
        originalLanguage = try? values?.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try? values?.decodeIfPresent(String.self, forKey: .originalTitle)
        voteAverage = try? values?.decodeIfPresent(Double.self, forKey: .voteAverage)
        releaseDate = try? values?.decodeIfPresent(String.self, forKey: .releaseDate)
    }
    
}

struct TVShow : Codable {
    var page : Int?
    var totalPages : Int?
    var totalResults : Int?
    var results : [TVShowResult]?
    
    enum CodingKeys: String, CodingKey {
           case page = "page"
           case totalPages = "total_pages"
           case totalResults = "total_results"
           case results = "results"
    }

   init(from decoder: Decoder) throws {
       let values = try? decoder.container(keyedBy: CodingKeys.self)
       page = try? values?.decodeIfPresent(Int.self, forKey: .page)
       totalPages = try? values?.decodeIfPresent(Int.self, forKey: .totalPages)
       totalResults = try? values?.decodeIfPresent(Int.self, forKey: .totalResults)
       results = try? values?.decodeIfPresent([TVShowResult].self, forKey: .results)
   }
}
struct TVShowResult : Codable{
    var id : Int64?
    var popularity : Double?
    var originalName : String?
    var name : String?
    var voteCount : Int?
    var posterPath : String?
    var backdropPath : String?
    var originalLanguage : String?
    var voteAverage : Double?
    var overview : String?
    var firstAirDate : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case popularity = "popularity"
        case originalName = "original_name"
        case name = "name"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case overview = "overview"
        case firstAirDate = "first_air_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        popularity = try? values?.decodeIfPresent(Double.self, forKey: .popularity)
        voteCount = try? values?.decodeIfPresent(Int.self, forKey: .voteCount)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try? values?.decodeIfPresent(String.self, forKey: .backdropPath)
        originalLanguage = try? values?.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalName = try? values?.decodeIfPresent(String.self, forKey: .originalName)
        voteAverage = try? values?.decodeIfPresent(Double.self, forKey: .voteAverage)
        firstAirDate = try? values?.decodeIfPresent(String.self, forKey: .firstAirDate)
    }
    
}
struct MovieDetail : Codable{
    var id : Int64?
    var posterPath : String?
    var originalTitle : String?
    var voteAverage : Double?
    var overview : String?
    var genres : [Genres]?
    var status : String?
    var homePage : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case genres = "genres"
        case status = "status"
        case homePage = "homepage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        originalTitle = try? values?.decodeIfPresent(String.self, forKey: .originalTitle)
        voteAverage = try? values?.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try? values?.decodeIfPresent(String.self, forKey: .overview)
        genres = try? values?.decodeIfPresent([Genres].self, forKey: .genres)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        homePage = try? values?.decodeIfPresent(String.self, forKey: .homePage)
    }
    
}
struct TVShowDetail : Codable{//Movie Detail ile benzer modelde ancak farklı yapılmasının sebebi codingKey kısmındaki json yapısında isimlerin farklı olması
    var id : Int64?
    var posterPath : String?
    var originalTitle : String?
    var voteAverage : Double?
    var overview : String?
    var genres : [Genres]?
    var status : String?
    var homePage : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case originalTitle = "original_name"
        case voteAverage = "vote_average"
        case overview = "overview"
        case genres = "genres"
        case status = "status"
        case homePage = "homepage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        originalTitle = try? values?.decodeIfPresent(String.self, forKey: .originalTitle)
        voteAverage = try? values?.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try? values?.decodeIfPresent(String.self, forKey: .overview)
        genres = try? values?.decodeIfPresent([Genres].self, forKey: .genres)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        homePage = try? values?.decodeIfPresent(String.self, forKey: .homePage)
    }
    
}
struct Genres : Codable{
    var id : Int64?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
    }
    
}
struct MovieCast : Codable{
    var id : Int64?
    var cast : [CastList]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        cast = try? values?.decodeIfPresent([CastList].self, forKey: .cast)
    }
    
}

struct CastList : Codable{
    var id : Int64?
    var name : String?
    var profilePath : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        profilePath = try? values?.decodeIfPresent(String.self, forKey: .profilePath)
    }
    
}
