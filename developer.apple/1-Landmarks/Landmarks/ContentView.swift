//
//  ContentView.swift
//  Landmarks
//
//  Created by Derek Stephen McLean on 09/04/2020.
//  Copyright © 2020 Derek Stephen McLean. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                Text("Loch Lomond")
                    .font(.title)
                HStack {
                    Text("Trossachs National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("Scotland")
                        .font(.subheadline)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
