//
//  SettingsRowView.swift
//  BruinBites
//
//  Created by Susie Kim on 7/7/25.
//

import SwiftUI

struct SettingsRowView: View {
    let ImageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: ImageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsRowView(ImageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
