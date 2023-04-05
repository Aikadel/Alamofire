//
//  ViewController.swift
//  HarryPotterRandomizer
//
//  Created by Arman Myrzakanurov on 22.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var houseName: UILabel!
    
    var manager = HarryPotterManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        let randomId = manager.idList.randomElement()!
//        manager.fetchHouse(with: randomId!)
        manager.fetchAlamofireHouse(with: randomId)
    }
}

extension ViewController: HarryPotterManagerDelegate {
    
    func onHouseModelDidUpdate(with model: HouseModel) {
        houseName.text = model.name
    }
}
