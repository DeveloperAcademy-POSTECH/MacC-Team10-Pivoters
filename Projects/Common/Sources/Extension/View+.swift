//
//  View+.swift
//  Common
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI



public extension View {
    /// 공유 시트를 표시하기 위한 메소드
    func showShareSheet(with activityItems: [Any], isSharing: Binding<Bool>) {
        let activityVC = CustomActivityViewController(activityItems: activityItems, applicationActivities: nil)

        // 공유 화면을 닫을 때, 상태값을 false로 설정
        activityVC.onDismiss = {
            isSharing.wrappedValue = false
        }

        // 현재 활성화된 UIWindowScene을 가져와 activityVC를 모달로 표시
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootViewController.present(activityVC, animated: true)
            }
        }
    }

    /// SwiftUI 뷰의 스냅샷을 캡처하는 메소드
    func snapshot() -> UIImage? {
        let controller = UIHostingController(rootView: self)

        let view = controller.view
        let targetSize = CGSize(width: 200, height: 200)
        view?.frame = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        view?.layoutIfNeeded()

        // 내부적으로 렌더링 수행
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }

    func teamCellViewModifier() -> some View {
        modifier(TeamCellModifier())
    }
}
