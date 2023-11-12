//
//  TeamChangeModalView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/12/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI
import Common

struct TeamChangeModalView: View {
    @State private var selectedItem: String? = "Item 1"
    var body: some View {
        VStack {
            TeamList(selectedItem: $selectedItem)
        }
        .presentationDetents([.height(334), .medium, .large])
        .presentationBackground(.regularMaterial)
    }
}

struct TeamList: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    @Binding var selectedItem: String?

    var body: some View {
        ForEach(items, id: \.self) { item in
            VStack {
                HStack {
                    Image(asset: CommonAsset.uniform)
                        .resizable()
                        .opacity(item == selectedItem ? 1 : 0.4)
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 60)

                    VStack {
                        Text("울산현대 FC")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text("스쿼드 1개")
                            .font(.system(size: 10))
                    }
                }
            }
            .frame(width: 272, height: 62)
            .background(item == selectedItem ? Color.white : Color.white.opacity(0.6))
            .foregroundStyle(item == selectedItem ? Color.black : Color.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .onTapGesture {
                selectedItem = item
                print("Selected item: \(item)")
            }
        }
    }
}
