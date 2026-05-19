//
//  ContentView.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 19/04/26.
//

import SwiftUI

/// This is a welcome screen (total 6 page)
struct WelcomeScreenView: View {
   
    var body: some View {
        VStack(spacing: 20) {
            Text("Regular")
                .font(.custom("Inter18pt-Regular", size: 18))

            Text("Bold")
                .font(.custom("Inter18pt-BoldItalic", size: 14))
        }
    }
}

#Preview {
    WelcomeScreenView()
}
