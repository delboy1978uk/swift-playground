//
//  CircleImage.swift
//  Landmarks
//
//  Created by Derek Stephen McLean on 10/04/2020.
//  Copyright © 2020 Derek Stephen McLean. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("lochlomond")
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: 200, height: 200, alignment: .center)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
