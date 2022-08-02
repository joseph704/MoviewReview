//
//  MoviewSearchResponseModel.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/02.
//

import Foundation

struct MoviewSearchResponseModel: Decodable {
    var items: [Movie] = []
}
