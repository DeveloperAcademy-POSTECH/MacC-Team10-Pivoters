//
//  SheetModifier.swift
//  Common
//
//  Created by 한지석 on 11/29/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct SheetModifier: ViewModifier {

    let isEdit: Bool
    let presentationDetents: Set<PresentationDetent>
    @Binding var selection: PresentationDetent

    func body(content: Content) -> some View {
        content
            .presentationDragIndicator(isEdit ? .visible : .hidden)
            .presentationDetents(presentationDetents,
                                 selection: $selection)
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled()
    }
}
