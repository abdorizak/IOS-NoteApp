//
//  NetworkManager.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 11/30/21.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    var delegate: DataDelegate?
    let apiURL = "http://192.168.1.9:6000/api/note"
    
     func fetNotes() {
        AF.request(apiURL).response { [weak self] response in
            guard let data = response.data else { return }
            let resultData = String(data: data, encoding: .utf8)
            self?.delegate?.updateNotes(newNotes: resultData ?? "")
        }
    }
    
    func addNotes(parameters: [String: String]) {
        AF.request(apiURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            
        }
    }
}
