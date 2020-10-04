//
//  DetailViewController.swift
//  MoviesBook
//
//  Created by Semafor on 3.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieSatus: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var name = String()
    var movieImage = String()
    var rating = Double()
    var overview = String()
    var status = String()
    var genres = [Genres]()
    var castListViewModel : CastListViewModel!
    var genresText = String()
    var checkNavigation = String()
    var homePage = String()
    
    var viewModel: MovieDetail? {
          didSet {
            updateView()
       }
    }
    var TVViewModel: TVShowDetail? {
          didSet {
            updateView()
       }
    }
    var castViewModel: MovieCast? {
         didSet {
           updateCastView()
      }
   }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + movieImage), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        movieName.text = name
        movieRating.text = String(rating)
        movieSatus.text = status
        overviewTextView.text = overview
        for genresItem in genres{
           
            genresText += ((genresItem.name ?? "") + "  ")
        }
        movieGenres.text = genresText
    }
    
    func updateView() {
        if let viewModel = viewModel {
            if let name = viewModel.originalTitle{
                self.name = name
            }
            if let movieImage = viewModel.posterPath{
                self.movieImage = movieImage
            }
            if let name = viewModel.originalTitle{
                self.name = name
            }
            if let rating = viewModel.voteAverage{
                self.rating = rating
            }
            if let overview = viewModel.overview{
                self.overview = overview
            }
            if let status = viewModel.status{
                self.status = status
            }
            if let genres = viewModel.genres{
                self.genres = genres
            }
            if let homepage = viewModel.homePage{
                self.homePage = homepage
            }
        }
        if let viewModel = TVViewModel {
            if let name = viewModel.originalTitle{
                self.name = name
            }
            if let movieImage = viewModel.posterPath{
                self.movieImage = movieImage
            }
            if let name = viewModel.originalTitle{
                self.name = name
            }
            if let rating = viewModel.voteAverage{
                self.rating = rating
            }
            if let overview = viewModel.overview{
                self.overview = overview
            }
            if let status = viewModel.status{
                self.status = status
            }
            if let genres = viewModel.genres{
                self.genres = genres
            }
        }
    }
    func updateCastView() {
        if let viewModel = castViewModel {
            if let cast = viewModel.cast{
                self.castListViewModel = CastListViewModel(cast: cast)
            }
        }
    }
    @IBAction func goWebPageButton(_ sender: Any) {
        if let url = URL(string: homePage), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.castListViewModel.numberRownInSection()
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
        let viewModel = self.castListViewModel.casttoAtIndex(index: indexPath.row)
        cell.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + viewModel.profilePath), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        cell.name.text = viewModel.name
        return cell
       }
}
