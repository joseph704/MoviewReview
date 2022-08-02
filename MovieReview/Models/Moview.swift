//
//  Moview.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/02.
//

import Foundation

struct Movie: Decodable {
    let title: String
    private let image: String
    let userRating: String
    let actor: String
    let director: String
    let pubDate: String
    
    var imageURL: URL? { URL(string: image) }
}
