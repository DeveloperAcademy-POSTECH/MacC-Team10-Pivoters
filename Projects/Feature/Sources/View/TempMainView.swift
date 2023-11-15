////
////  TempMainView.swift
////  Feature
////
////  Created by 한지석 on 11/9/23.
////  Copyright © 2023 com.pivoters. All rights reserved.
////
//
//import SwiftUI
//
//import Common
//
//public struct TempMainView: View {
//    @State private var fieldObservable = FieldObservable()
//
//    @State var isPresented = true
//    @State var currentPresentationDetent: PresentationDetent = .fraction(0.2)
//    let presentationDetent: Set<PresentationDetent> = [.fraction(0.2), .fraction(0.45)]
//    let editHeight = UIScreen.main.bounds.size.height * 0.43
//    let defaultHeight = UIScreen.main.bounds.size.height * 0.2
//
//    public init() { }
//
//    public var body: some View {
//        NavigationView {
//            VStack {
//                Spacer()
//                FieldView()
//                    .environment(fieldObservable)
//                    .animation(.default, value: currentPresentationDetent)
//                    .padding(.bottom, currentPresentationDetent == .fraction(0.2) ? defaultHeight : editHeight)
//            }
//        }
//        .sheet(isPresented: $isPresented) {
//            if currentPresentationDetent == .fraction(0.45) {
//                ModalSegmentedView()
//                    .environment(fieldObservable)
//                    .presentationDragIndicator(.visible)
//                    .presentationDetents(presentationDetent, selection: $currentPresentationDetent)
//                    .presentationBackgroundInteraction(.enabled)
//                    .interactiveDismissDisabled()
//            } else {
//                Text("밀어올려서 편집하기")
//                    .presentationDragIndicator(.hidden)
//                    .presentationDetents(presentationDetent, selection: $currentPresentationDetent)
//                    .presentationBackgroundInteraction(.enabled)
//                    .interactiveDismissDisabled()
//            }
//        }
//    }
//}
