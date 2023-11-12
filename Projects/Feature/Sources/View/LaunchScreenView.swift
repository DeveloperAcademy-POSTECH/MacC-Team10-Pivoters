//
//  LaunchScreenView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/13/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.74, green: 0.74, blue: 0.74), location: 0.00),
            Gradient.Stop(color: Color(red: 0.74, green: 0.74, blue: 0.74).opacity(0), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1))
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Linable")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text("the most beautiful lineup maker")
                    .font(Font.custom("SUIT", size: 14))
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LaunchScreenView()
}
