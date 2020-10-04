//
//  WebService.swift
//  MoviesBook
//
//  Created by Semafor on 3.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import Foundation

class WebService{
    func downloadMovies(urlTopRated : URL,urlPopular : URL,urlNowPlaying: URL, completionHandler: @escaping(Movies?,Movies?,Movies?) -> ()){
        URLSession.shared.dataTask(with: urlTopRated) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil,nil,nil)
            }else if let data = data {
                let moviesTopRated = try? JSONDecoder().decode(Movies.self, from: data)
                if let moviesTop = moviesTopRated{
                    URLSession.shared.dataTask(with: urlPopular) { (popularData, popularResponse, popularError) in
                        if let error = popularError {
                            print(error)
                            completionHandler(nil,nil,nil)
                        }else if let popularData = popularData {
                            let moviesPopular = try? JSONDecoder().decode(Movies.self, from: popularData)
                            if let moviesPopular = moviesPopular{
                                URLSession.shared.dataTask(with: urlNowPlaying) { (playingData, response, error) in
                                    if let error = error {
                                        print(error)
                                        completionHandler(nil,nil,nil)
                                    }else if let playingData = playingData {
                                        let moviesPlaying = try? JSONDecoder().decode(Movies.self, from: playingData)
                                        if let moviesPlaying = moviesPlaying{
                                            completionHandler(moviesTop,moviesPopular,moviesPlaying)
                                        }
                                    }
                                }.resume()
                            }
                        }
                    }.resume()
                }
            }
        }.resume()
    }
    func downloadMovie(url : URL, completionHandler: @escaping(Movies?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil)
            }else if let data = data {
                let moviesTopRated = try? JSONDecoder().decode(Movies.self, from: data)
                if let moviesTop = moviesTopRated{
                    completionHandler(moviesTop)
                }
            }
        }.resume()
    }
    func downloadTVShow(url : URL, completionHandler: @escaping(TVShow?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil)
            }else if let data = data {
                let tvShow = try? JSONDecoder().decode(TVShow.self, from: data)
                if let show = tvShow{
                    completionHandler(show)
                }
            }
        }.resume()
    }
    func downloadTVShow(urlTopRated : URL,urlPopular : URL, completionHandler: @escaping(TVShow?,TVShow?) -> ()){
        URLSession.shared.dataTask(with: urlTopRated) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil,nil)
            }else if let data = data {
                let moviesTopRated = try? JSONDecoder().decode(TVShow.self, from: data)
                if let moviesTop = moviesTopRated{
                    URLSession.shared.dataTask(with: urlPopular) { (popularData, popularResponse, popularError) in
                        if let error = popularError {
                            print(error)
                            completionHandler(nil,nil)
                        }else if let popularData = popularData {
                            let moviesPopular = try? JSONDecoder().decode(TVShow.self, from: popularData)
                            if let moviesPopular = moviesPopular{
                                completionHandler(moviesTop,moviesPopular)
                            }
                        }
                    }.resume()
                }
            }
        }.resume()
    }
    func downloadMoviesDetail(urlDetail : URL,urlCast : URL, completionHandler: @escaping(MovieDetail?,MovieCast?) -> ()){
        URLSession.shared.dataTask(with: urlDetail) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil,nil)
            }else if let data = data {
                    let movies = try? JSONDecoder().decode(MovieDetail.self, from: data)
                      if let moviesDetail = movies{
                          URLSession.shared.dataTask(with: urlCast) { (castData, castResponse, castError) in
                              if let error = castError {
                                  print(error)
                                  completionHandler(nil,nil)
                              }else if let cast = castData {
                                  let moviesCast = try? JSONDecoder().decode(MovieCast.self, from: cast)
                                  if let movieCast = moviesCast{
                                      completionHandler(moviesDetail,movieCast)
                                  }
                              }
                          }.resume()
                    }
            }//
        }.resume()
    }
    
    func downloadShowsDetail(urlDetail : URL,urlCast : URL, completionHandler: @escaping(TVShowDetail?,MovieCast?) -> ()){
        URLSession.shared.dataTask(with: urlDetail) { (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil,nil)
            }else if let data = data {
                    let tvShows = try? JSONDecoder().decode(TVShowDetail.self, from: data)
                        if let tvDetail = tvShows{
                            URLSession.shared.dataTask(with: urlCast) { (castData, castResponse, castError) in
                                if let error = castError {
                                    print(error)
                                    completionHandler(nil,nil)
                                }else if let cast = castData {
                                    let showCast = try? JSONDecoder().decode(MovieCast.self, from: cast)
                                    if let showCast = showCast{
                                        completionHandler(tvDetail,showCast)
                                    }
                                }
                            }.resume()
                      }
            }//
        }.resume()
    }




}
 
