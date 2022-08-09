//
//  MovieDetailPresenter.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/09.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func setupViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

final class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        movie: Movie,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movie = movie
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidload() {
        viewController?.setupViews(with: movie)
        viewController?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        movie.isLiked.toggle()
        
        if movie.isLiked {
            userDefaultsManager.addMovie(movie)
        } else {
            userDefaultsManager.removeMovie(movie)
        }
        
        viewController?.setRightBarButton(with: movie.isLiked)
    }
}
