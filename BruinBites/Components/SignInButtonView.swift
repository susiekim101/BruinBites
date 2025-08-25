//
//  SignInButtonView.swift
//  BruinBites
//
//  Created by Susie Kim on 7/6/25.
//

import SwiftUI

struct SignInButtonView: View {
    var text: String
    var icon: String
    
    var body: some View {
        Button {
            print("Log user in...")
        } label: {
            HStack {
                Text(text)
                    .fontWeight(.semibold)
                Image(systemName: icon)
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding(.top, 24)
    }
}

//#Preview {
//    SignInButtonView(text: "SIGN IN", icon: "arrow.right")
//}
