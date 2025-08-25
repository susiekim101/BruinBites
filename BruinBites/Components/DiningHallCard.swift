//
//  DiningHallCard.swift
//  BruinBites
//
//  Created by Susie Kim on 8/25/25.
//

import SwiftUI

struct DiningHallCard: View {
    @StateObject var viewModel = DiningHallViewModel()
    let name: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image("filler-image")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            VStack(alignment: .leading) {
                if let hall = viewModel.hall {
                    Text(hall.name)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 2)
                    
                    Text("Breakfast: \(hall.breakfast)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Lunch: \(hall.lunch)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Dinner: \(hall.dinner)")
                        .foregroundColor(.secondary)
                    
                    Text("Extended Dinner: \(hall.extended)")
                        .foregroundColor(.secondary)
                    
                    Button {
                        print("Show Menu")
                    } label: {
                        Text("View Menu")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                          
                    }
                    
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    ProgressView()
                }
            }
        }
        .task {
            await viewModel.fetchDiningHall(named: name)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
    DiningHallCard(name: "Covel Dining")
}
