//
//  HarryPotterManager.swift
//  HarryPotterRandomizer
//
//  Created by Arman Myrzakanurov on 22.05.2022.
//

import Foundation
import Alamofire

private struct Constants {
    static let houseURL: String = "https://wizard-world-api.herokuapp.com/Houses/"
}

protocol HarryPotterManagerDelegate: AnyObject {
    func onHouseModelDidUpdate(with model: HouseModel)
}

struct HarryPotterManager {
    
    weak var delegate: HarryPotterManagerDelegate?
    
    let idList: [String] = [
        "0367baf3-1cb6-4baf-bede-48e17e1cd005",
        "805fd37a-65ae-4fe5-b336-d767b8b7c73a",
        "85af6295-fd01-4170-a10b-963dd51dce14",
        "a9704c47-f92e-40a4-8771-ed1899c9b9c1"
    ]
    
    // URLSession network request example
    func fetchHouse(with id: String) {
        guard let url = URL(string: Constants.houseURL + id) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error \(error)")
            } else {
                guard let safeData = data else { return }
                parseJSON(from: safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(from data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(HouseModel.self, from: data)
            DispatchQueue.main.async {
                self.delegate?.onHouseModelDidUpdate(with: decodedData)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Alamofire network request example
    func fetchAlamofireHouse(with id: String) {
        // 1. import Alamofire library
        // 2. Use global object 'AF' from Alamofire library to make request
        // 3. AF.request(yourURL) -> pass url to function to make request
        // 4. AF.request(yourURL).responseDecodable(of: Decodable Structure with Decodable protocol)
        // 5. Remove all unused parameters except 'of' and 'completionHandler'
        // 6. Press enter on 'completionHandler'
        // 7. Switch on 'response.result' -> when success you will get Decodable Model
        // 8. 'response.result' -> when failure you will get an error
        // 9. On Success -> Do smth with model
        // 10. On Failer -> Print Error
        AF.request(Constants.houseURL + id).responseDecodable(of: HouseModel.self) { response in
            switch response.result {
            case .success(let model):
                delegate?.onHouseModelDidUpdate(with: model)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
