//
//  MoviesViewController.swift
//  MoviesBook
//
//  Created by Semafor on 2.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit
import SDWebImage
let apiKey = "9bf95a9e98335328ddae6500bf078499"

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movieTopRatedListViewModel : MovieListViewModel!
    var moviePopularListViewModel : MovieListViewModel!
    var moviePlayingListViewModel : MovieListViewModel!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var urlStringTopRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page="
    var urlTopRated: URL!
    var urlStringPopular = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page="
    var urlPopular: URL!
    var urlStringNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page="
    var urlNowPlaying: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
    func getData(){
        if !CheckInternet.Connection(){
            self.Alert(Message: "Your Device is not connected with internet!")
        }else{
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
           // self.activityIndicator.style = UIActivityIndicatorView.Style.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            urlStringTopRated += "1"
            urlTopRated = URL(string: urlStringTopRated)!
            urlStringPopular += "1"
            urlPopular = URL(string: urlStringPopular)!
            urlStringNowPlaying += "1"
            urlNowPlaying = URL(string: urlStringNowPlaying)!
            
            WebService().downloadMovies(urlTopRated: urlTopRated,urlPopular:urlPopular,urlNowPlaying:urlNowPlaying) { (movies,popularMovies,playingMovies) in
                DispatchQueue.main.async {
                    if let movies = movies{
                        if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                            self.movieTopRatedListViewModel = MovieListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!)
                            
                            if let popularMovies = popularMovies{
                                if popularMovies.totalPages != nil && popularMovies.totalResults != nil && popularMovies.page != nil && popularMovies.results != nil{
                                    self.moviePopularListViewModel = MovieListViewModel(page: popularMovies.page!, totalPages: popularMovies.totalPages!, totalResults: popularMovies.totalResults!, results: popularMovies.results!)
                                    
                                    if let playingMovies = playingMovies{
                                        if playingMovies.totalPages != nil && playingMovies.totalResults != nil && playingMovies.page != nil && playingMovies.results != nil{
                                            self.moviePlayingListViewModel = MovieListViewModel(page: playingMovies.page!, totalPages: playingMovies.totalPages!, totalResults: playingMovies.totalResults!, results: playingMovies.results!)
                                            DispatchQueue.main.async {
                                                
                                                self.tableView.reloadData()
                                            }
                                        }
                                    }
                                }
                            }
                        }else{
                            self.Alert(Message: "An error has occurred! Movies could not be fetched!")
                        }
                    }
                    //self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.hidesWhenStopped = true
                }
            }
        }
    }
    func Alert (Message: String){
       let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
       self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        switch section
        {
            case 0:
                return "Top Rated"
            case 1:
                return "Popular"
            default:
                return "Now Playing"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return self.movieTopRatedListViewModel == nil ? 0 : self.movieTopRatedListViewModel.numberRownInSection()
        }
        if collectionView.tag == 1{
            return self.moviePopularListViewModel == nil ? 0 : self.moviePopularListViewModel.numberRownInSection()
        }
        if  collectionView.tag == 2{
            return self.moviePlayingListViewModel == nil ? 0 : self.moviePlayingListViewModel.numberRownInSection()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        if collectionView.tag == 0{
            let movieViewModel = self.movieTopRatedListViewModel.movietoAtIndex(index: indexPath.row)
            cell.movieRate.text = String(movieViewModel.voteAverage)
            cell.movieTitle.text = movieViewModel.originalTitle
           cell.movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + movieViewModel.posterPath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        if collectionView.tag == 1{
           let movieViewModel = self.moviePopularListViewModel.movietoAtIndex(index: indexPath.row)
            cell.movieRate.text = String(movieViewModel.voteAverage)
            cell.movieTitle.text = movieViewModel.originalTitle
            cell.movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + movieViewModel.posterPath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        if collectionView.tag == 2{
           let movieViewModel = self.moviePlayingListViewModel.movietoAtIndex(index: indexPath.row)
            cell.movieRate.text = String(movieViewModel.voteAverage)
            cell.movieTitle.text = movieViewModel.originalTitle
            cell.movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + movieViewModel.posterPath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailUrl = "https://api.themoviedb.org/3/movie/"
        var castUrl = "https://api.themoviedb.org/3/movie/"
        
        if collectionView.tag == 0{
            print("\(indexPath.row) : Top Rated")
            let movieViewModel = self.movieTopRatedListViewModel.movietoAtIndex(index: indexPath.row)
            print(movieViewModel.id)
            detailUrl += "\(movieViewModel.id)?api_key=\(apiKey)&language=en-US"
            castUrl += "\(movieViewModel.id)/credits?api_key=\(apiKey)"
            selectCellAction(detailUrl: detailUrl, castUrl: castUrl)
        }
        if collectionView.tag == 1{
          print("\(indexPath.row) : More Popular")
            let movieViewModel = self.moviePopularListViewModel.movietoAtIndex(index: indexPath.row)
            print(movieViewModel.id)
            detailUrl += "\(movieViewModel.id)?api_key=\(apiKey)&language=en-US"
            castUrl += "\(movieViewModel.id)/credits?api_key=\(apiKey)"
            selectCellAction(detailUrl: detailUrl, castUrl: castUrl)
        }
        if collectionView.tag == 2{
           print("\(indexPath.row) : Now Playing")
            let movieViewModel = self.moviePlayingListViewModel.movietoAtIndex(index: indexPath.row)
            print(movieViewModel.id)
            detailUrl += "\(movieViewModel.id)?api_key=\(apiKey)&language=en-US"
            castUrl += "\(movieViewModel.id)/credits?api_key=\(apiKey)"
            selectCellAction(detailUrl: detailUrl, castUrl: castUrl)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
         print("On Completetion")
         //requests another set of data (20 more items) from the server.
         //DispatchQueue.main.async(execute: collectionView.reloadData)
        //show more
           
            if collectionView.tag == 0{
                if movieTopRatedListViewModel.page + 1 < movieTopRatedListViewModel.totalPages {
                    urlStringTopRated =  String(urlStringTopRated.dropLast())
                    urlStringTopRated += String(movieTopRatedListViewModel.page+1)
                    urlTopRated = URL(string: urlStringTopRated)!
                    self.activityIndicator.center = self.view.center
                     self.activityIndicator.hidesWhenStopped = true
                     self.view.addSubview(self.activityIndicator)
                     self.activityIndicator.startAnimating()
                    WebService().downloadMovie(url: urlTopRated) { (movies) in
                        DispatchQueue.main.async {
                            if let movies = movies{
                                if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                                    self.movieTopRatedListViewModel.moviesAppendList(movie: MovieListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!))
                                    self.tableView.reloadData()
                                }
                            }
                            //self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.hidesWhenStopped = true
                        }
                    }
                }
            }
           
            if collectionView.tag == 1{
                if moviePopularListViewModel.page + 1 < moviePopularListViewModel.totalPages {
                    urlStringPopular = String(urlStringPopular.dropLast())
                    urlStringPopular += String(moviePopularListViewModel.page+1)
                    urlPopular = URL(string: urlStringPopular)!
                    self.activityIndicator.center = self.view.center
                     self.activityIndicator.hidesWhenStopped = true
                     self.view.addSubview(self.activityIndicator)
                     self.activityIndicator.startAnimating()
                    WebService().downloadMovie(url: urlPopular) { (movies) in
                        DispatchQueue.main.async {
                            if let movies = movies{
                                if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                                    self.moviePopularListViewModel.moviesAppendList(movie: MovieListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!))
                                    self.tableView.reloadData()
                                }
                            }
                            //self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.hidesWhenStopped = true
                        }
                    }
                }
            }
           
            if collectionView.tag == 2{
                if moviePlayingListViewModel.page + 1 < moviePlayingListViewModel.totalPages {
                    urlStringNowPlaying = String(urlStringNowPlaying.dropLast())
                    urlStringNowPlaying += String(moviePlayingListViewModel.page+1)
                    urlNowPlaying = URL(string: urlStringNowPlaying)!
                    self.activityIndicator.center = self.view.center
                     self.activityIndicator.hidesWhenStopped = true
                     self.view.addSubview(self.activityIndicator)
                     self.activityIndicator.startAnimating()
                    WebService().downloadMovie(url: urlNowPlaying) { (movies) in
                        DispatchQueue.main.async {
                            if let movies = movies{
                                if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                                    self.moviePlayingListViewModel.moviesAppendList(movie: MovieListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!))
                                    self.tableView.reloadData()
                                }
                            }
                            //self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.hidesWhenStopped = true
                        }
                    }
                }
            }
            
        }
    }
    func selectCellAction(detailUrl:String,castUrl:String){
        WebService().downloadMoviesDetail(urlDetail:URL(string: detailUrl)!,urlCast:URL(string: castUrl)!) { (detail, cast) in
            DispatchQueue.main.async {
                if detail?.id != 0{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                    vc?.viewModel = detail
                    vc?.castViewModel = cast
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        }
    }
}

/*
extension UIImageView {
    public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {
      
            if let url = NSURL(string: urlString) {
               if let data = NSData(contentsOf: url as URL) {
                let image = UIImage(data: data as Data)
                    self.image = image
               }else{
                   self.image = PlaceHolderImage
               }
           }
           else{
              self.image = PlaceHolderImage
           }
       }
}
*/
