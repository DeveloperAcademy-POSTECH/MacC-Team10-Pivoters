//
//  PlayerSelectionView.swift
//  Presentation
//
//  Created by 박승찬 on 1/20/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftUI

import Domain

struct PlayerSelectionView: View {

    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                addPlayerCell()

            }
        }
    }

    func addPlayerCell() -> some View {
        VStack {
            Image(systemName: "plus")
        }
    }
}

struct PlayerCell: View {
    @Binding var player: Player
    var body: some View {
        VStack {
            Text("\(player.name)")
        }
    }
}

#Preview {
    PlayerSelectionView()
}
