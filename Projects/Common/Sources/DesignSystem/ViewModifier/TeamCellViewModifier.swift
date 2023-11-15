//
//  TeamCellViewModifier.swift
//  Common
//
//  Created by 한지석 on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct TeamCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
            .listRowBackground(regularMaterial())
    }

    func regularMaterial() -> some View {
        Rectangle()
            .fill(.regularMaterial)
    }
}
