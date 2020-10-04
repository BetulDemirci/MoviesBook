//
//  TVShowViewController.swift
//  MoviesBook
//
//  Created by Semafor on 2.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit

class TVShowViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var tvShowTopRatedListViewModel : TVShowListViewModel!
    var tvShowPopularListViewModel : TVShowListViewModel!
    
    var urlStringTopRated = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page="
    var urlTopRated: URL!
    var urlStringPopular = "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page="
    var urlPopular: URL!
    
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
            //self.activityIndicator.style = UIActivityIndicatorView.Style.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            urlStringTopRated += "1"
            urlTopRated = URL(string: urlStringTopRated)!
            urlStringPopular += "1"
            urlPopular = URL(string: urlStringPopular)!
            WebService().downloadTVShow(urlTopRated: urlTopRated,urlPopular:urlPopular) { (movies,popularMovies) in
                DispatchQueue.main.async {
                    if let movies = movies{
                        if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                            self.tvShowTopRatedListViewModel = TVShowListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!)
                            
                            if let popularMovies = popularMovies{
                                if popularMovies.totalPages != nil && popularMovies.totalResults != nil && popularMovies.page != nil && popularMovies.results != nil{
                                    self.tvShowPopularListViewModel = TVShowListViewModel(page: popularMovies.page!, totalPages: popularMovies.totalPages!, totalResults: popularMovies.totalResults!, results: popularMovies.results!)
                                    
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
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
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowTableViewCell", for: indexPath) as! TVShowTableViewCell
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
            default:
                return "Popular"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50;
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return self.tvShowTopRatedListViewModel == nil ? 0 : self.tvShowTopRatedListViewModel.numberRowInSection()
        }
        if collectionView.tag == 1{
             return self.tvShowPopularListViewModel == nil ? 0 : self.tvShowPopularListViewModel.numberRowInSection()
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowCollectionViewCell", for: indexPath) as! TVShowCollectionViewCell
        if collectionView.tag == 0{
           let tvShowViewModel = self.tvShowTopRatedListViewModel.tvShowtoAtIndex(index: indexPath.row)
           cell.showRate.text = String(tvShowViewModel.voteAverage)
           cell.showTitle.text = tvShowViewModel.originalTitle
           cell.showImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + tvShowViewModel.posterPath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        if collectionView.tag == 1{
           let tvShowViewModel = self.tvShowPopularListViewModel.tvShowtoAtIndex(index: indexPath.row)
            cell.showRate.text = String(tvShowViewModel.voteAverage)
            cell.showTitle.text = tvShowViewModel.originalTitle
            cell.showImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + tvShowViewModel.posterPath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailUrl = "https://api.themoviedb.org/3/tv/"
        var castUrl = "https://api.themoviedb.org/3/tv/"
       
        if collectionView.tag == 0{
            print("\(indexPath.row) : Top Rated")
            let tvShowViewModel = self.tvShowTopRatedListViewModel.tvShowtoAtIndex(index: indexPath.row)
            print(tvShowViewModel.id)
            detailUrl += "\(tvShowViewModel.id)?api_key=\(apiKey)&language=en-US"
            castUrl += "\(tvShowViewModel.id)/credits?api_key=\(apiKey)&language=en-US"
             selectCellAction(detailUrl: detailUrl, castUrl: castUrl)
        }
        if collectionView.tag == 1{
          print("\(indexPath.row) : More Popular")
            let tvShowViewModel = self.tvShowPopularListViewModel.tvShowtoAtIndex(index: indexPath.row)
            print(tvShowViewModel.id)
            detailUrl += "\(tvShowViewModel.id)?api_key=\(apiKey)&language=en-US"
                       castUrl += "\(tvShowViewModel.id)/credits?api_key=\(apiKey)&language=en-US"
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
                if tvShowTopRatedListViewModel.page + 1 < tvShowTopRatedListViewModel.totalPages {
                    urlStringTopRated =  String(urlStringTopRated.dropLast())
                    urlStringTopRated += String(tvShowTopRatedListViewModel.page+1)
                    urlTopRated = URL(string: urlStringTopRated)!
                    self.activityIndicator.center = self.view.center
                     self.activityIndicator.hidesWhenStopped = true
                     self.view.addSubview(self.activityIndicator)
                     self.activityIndicator.startAnimating()
                    WebService().downloadTVShow(url: urlTopRated) { (movies) in
                        DispatchQueue.main.async {
                            if let movies = movies{
                                if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                                    self.tvShowTopRatedListViewModel.showsAppendList(movie: TVShowListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!))
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
                if tvShowPopularListViewModel.page + 1 < tvShowPopularListViewModel.totalPages {
                    urlStringPopular =  String(urlStringPopular.dropLast())
                    urlStringPopular += String(tvShowPopularListViewModel.page+1)
                    urlPopular = URL(string: urlStringPopular)!
                    self.activityIndicator.center = self.view.center
                     self.activityIndicator.hidesWhenStopped = true
                     self.view.addSubview(self.activityIndicator)
                     self.activityIndicator.startAnimating()
                    WebService().downloadTVShow(url: urlPopular) { (movies) in
                        DispatchQueue.main.async {
                            if let movies = movies{
                                if movies.totalPages != nil && movies.totalResults != nil && movies.page != nil && movies.results != nil{
                                    self.tvShowPopularListViewModel.showsAppendList(movie: TVShowListViewModel(page: movies.page!, totalPages: movies.totalPages!, totalResults: movies.totalResults!, results: movies.results!))
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
        WebService().downloadShowsDetail(urlDetail:URL(string: detailUrl)!,urlCast:URL(string: castUrl)!) { (detail, cast) in
            DispatchQueue.main.async {
                if detail?.id != 0{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                    vc?.TVViewModel = detail
                    vc?.castViewModel = cast
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        }
    }
}
