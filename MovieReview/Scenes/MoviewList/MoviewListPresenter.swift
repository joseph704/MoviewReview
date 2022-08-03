//
//  MoviewListPresenter.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/02.
//

import UIKit

protocol MoviewListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
}

final class MoviewListPresenter: NSObject {
    private weak var viewController: MoviewListProtocol? // 메모리 릭
    
    private let moviewSearchManager: MoviewSearchManagerProtocol
    
    private var likedMovie: [Movie] = [
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021")
    ]
    
    private var currentMoviewSearchResult: [Movie] = []
    
    init(
        viewController: MoviewListProtocol,
        moviewSearchManager: MoviewSearchManagerProtocol = MoviewSearchManager()
    ) {
        self.viewController = viewController
        self.moviewSearchManager = moviewSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
}

// MARK: UISearchBarDelegate
extension MoviewListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMoviewSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviewSearchManager.request(from: searchText) { [weak self] movies in
            guard let self = self else { return }
            self.currentMoviewSearchResult = movies
            self.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

extension MoviewListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

extension MoviewListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviewListCollectionViewcell.identifier,
            for: indexPath
        ) as? MoviewListCollectionViewcell else { return UICollectionViewCell() }
        
        let movie = likedMovie[indexPath.item]
        cell.update(movie)
        
        return cell
    }
}

extension MoviewListPresenter: UITableViewDelegate {
    
}

extension MoviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMoviewSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMoviewSearchResult[indexPath.row].title
        
        return cell
    }
}
