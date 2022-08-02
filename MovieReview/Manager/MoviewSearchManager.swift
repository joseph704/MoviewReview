//
//  MoviewSearchManager.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/02.
//

import Alamofire
import Foundation

protocol MoviewSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void)
}

struct MoviewSearchManager: MoviewSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        let parameters = MoviewSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "vEGvCG_nNUgA25_bpO0g",
            "X-Naver-Client-Secret": "gYGDVxJUfy"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(
            of: MoviewSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
