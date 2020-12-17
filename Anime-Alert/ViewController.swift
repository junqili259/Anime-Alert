//
//  ViewController.swift
//  Anime-Alert
//
//  Created by Jun Qi Li on 12/12/20.
//  Copyright © 2020 Jun Qi Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Network()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getAnime()
    }


}


extension ViewController: AnimeModelProtocol {
    func animeRetrieved(_ anime: AnimePage) {
        print(anime)
    }
    
    
}
