//
//  APIResponses.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 12/1/21.
//

import Foundation

struct ApiResponse: Decodable {
    let success: Bool
    let message: String?
}
