//
//  DiningHall.swift
//  BruinBites
//
//  Created by Susie Kim on 8/25/25.
//

import Foundation
import FirebaseFirestore

struct DiningHall: Identifiable, Codable {
    let name: String
    let breakfast: String
    let lunch: String
    let dinner: String
    let extended: String
    
    var id: String { name }
    
}
