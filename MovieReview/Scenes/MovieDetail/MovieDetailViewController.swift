//
//  MovieDetailViewController.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/09.
//

import SnapKit
import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    private var presenter: MovieDetailPresenter!
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = MovieDetailPresenter(viewController: self, movie: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidload()
    }
}

extension MovieDetailViewController: MovieDetailProtocol {
    func setupViews(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let userRatingContentsStackView = MovieContentsStackView(title: "평점", contents: movie.userRating)
        let actorContentsStackView = MovieContentsStackView(title: "배우", contents: movie.actor)
        let directorContentsStackView = MovieContentsStackView(title: "감독", contents: movie.director)
        let pubDateContentsStackView = MovieContentsStackView(title: "제작년도", contents: movie.pubDate)
        
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8.0
        
        [
            userRatingContentsStackView,
            actorContentsStackView,
            directorContentsStackView,
            pubDateContentsStackView
        ].forEach { contentsStackView.addArrangedSubview($0)}
        
        [imageView, contentsStackView].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(imageView.snp.bottom).offset(inset)
        }
        
        if let imageURL = movie.imageURL {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
    func setRightBarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBarButtonItem.image = UIImage(systemName: imageName)
    }
}

private extension MovieDetailViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
