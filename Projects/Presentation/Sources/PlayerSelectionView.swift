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
    @State var observable: PlayerSelectionObservable
    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                addPlayerCell()
                    .onTapGesture {
                        observable.addPlayer(name: "딴", backNumber: 1)
                    }
                ForEach(observable.team.members) { player in
                    PlayerCell(player: player)
                }
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
    var player: Player
    var body: some View {
        VStack {
            Text("\(player.name)")
        }
    }
}
