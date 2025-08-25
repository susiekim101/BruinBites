//
//  DiningHallViewModel.swift
//  BruinBites
//
//  Created by Susie Kim on 8/25/25.
//

import Foundation
import FirebaseFirestore

@MainActor
class DiningHallViewModel: ObservableObject {
    @Published var hall: DiningHall?
    @Published var errorMessage: String?
    
    func fetchDiningHall(named name: String) async {
        do {
            let doc = try await Firestore.firestore()
                .collection("dining_halls")
                .document(name)
                .getDocument()
            
            guard let data = doc.data() else {
                throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No dining hall found"])
            }
            
            var hall = try Firestore.Decoder().decode(DiningHall.self, from: data)
            hall = DiningHall(name: hall.name, breakfast: hall.breakfast, lunch: hall.lunch, dinner: hall.dinner, extended: hall.extended)
            self.hall = hall
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
