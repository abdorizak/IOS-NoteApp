//
//  APIResponse.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 11/30/21.
//

import Foundation


struct Notes: Decodable {
    let id    : String
    let title : String
    let date  : String
    let note  : String
    
    enum codingkeys: String, CodingKey {
        case id = "_id", title, date, note
    }
}
