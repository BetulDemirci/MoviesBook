//
//  MovieViewModel.swift
//  MoviesBook
//
//  Created by Semafor on 3.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import Foundation

struct MovieListViewModel{
    var page : Int
    var totalPages : Int
    var totalResults : Int
    var results : [MovieResult]
}
extension MovieListViewModel{
    func numberRownInSection() -> Int{
        return self.results.count
    }
    func movietoAtIndex(index:Int) -> MovieViewModel{
        let movie = results[index]
        return MovieViewModel(movie: movie)
    }
    mutating func moviesAppendList(movie:MovieListViewModel){
        results.append(contentsOf: movie.results)
        totalPages = movie.totalPages
        totalResults = movie.totalResults
        page = movie.page
    }
}


struct TVShowListViewModel{
    var page : Int
    var totalPages : Int
    var totalResults : Int
    var results : [TVShowResult]
}
extension TVShowListViewModel{
    func numberRowInSection() -> Int{
        return self.results.count
    }
    func tvShowtoAtIndex(index:Int) -> TVShowViewModel{
        let tvShow = results[index]
        return TVShowViewModel(tvShow: tvShow)
    }
    mutating func showsAppendList(movie:TVShowListViewModel){
        results.append(contentsOf: movie.results)
        totalPages = movie.totalPages
        totalResults = movie.totalResults
        page = movie.page
    }
}

struct MovieViewModel{
    let movie : MovieResult
}
extension MovieViewModel{
    var id : Int64 {
        return self.movie.id!
    }
    var popularity : Double {
        return self.movie.popularity ?? 0
    }
    var voteCount : Int {
        return self.movie.voteCount ?? 0
    }
    var video : Bool {
        return self.movie.video ?? false
    }
    var posterPath : String {
        return self.movie.posterPath ?? ""
    }
    var backdropPath : String {
        return self.movie.backdropPath ?? ""
    }
    var originalLanguage : String {
        return self.movie.originalLanguage ?? ""
    }
    var originalTitle : String {
        return self.movie.originalTitle ?? ""
    }
    var title : String {
        return self.movie.title ?? ""
    }
    var voteAverage : Double {
        return self.movie.voteAverage ?? 0
    }
    var overview : String {
        return self.movie.overview ?? ""
    }
    var releaseDate : String {
        return self.movie.releaseDate ?? ""
    }
}
struct TVShowViewModel{
    let tvShow : TVShowResult
}
extension TVShowViewModel{
    var id : Int64 {
        return self.tvShow.id!
    }
    var popularity : Double {
        return self.tvShow.popularity ?? 0
    }
    var voteCount : Int {
        return self.tvShow.voteCount ?? 0
    }
    var posterPath : String {
        return self.tvShow.posterPath ?? ""
    }
    var backdropPath : String {
        return self.tvShow.backdropPath ?? ""
    }
    var originalLanguage : String {
        return self.tvShow.originalLanguage ?? ""
    }
    var originalTitle : String {
        return self.tvShow.originalName ?? ""
    }
    var title : String {
        return self.tvShow.name ?? ""
    }
    var voteAverage : Double {
        return self.tvShow.voteAverage ?? 0
    }
    var overview : String {
        return self.tvShow.overview ?? ""
    }
    var releaseDate : String {
        return self.tvShow.firstAirDate ?? ""
    }
}
struct CastListViewModel{
    let cast : [CastList]
}
extension CastListViewModel{
    func numberRownInSection() -> Int{
        return self.cast.count
    }
    func casttoAtIndex(index:Int) -> CastViewModel{
        let castList = cast[index]
        return CastViewModel(cast: castList)
    }
}
struct CastViewModel{
    let cast : CastList
}
extension CastViewModel{
    var id : Int64 {
        return self.cast.id!
    }
    var name : String {
        return self.cast.name ?? ""
    }
    var profilePath : String {
        return self.cast.profilePath ?? ""
    }
}
