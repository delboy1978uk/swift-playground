//
//  UserData.swift
//  Landmarks
//
//  Created by Derek Stephen McLean on 10/04/2020.
//  Copyright © 2020 Apple. All rights reserved.
//


import SwiftUI
import Combine


final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
