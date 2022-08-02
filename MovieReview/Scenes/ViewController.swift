//
//  ViewController.swift
//  MovieReview
//
//  Created by Joseph Cha on 2022/08/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviewSearchManager().request(
            from: "Starwars") { movies in
                print(movies)
            }
    }

}
