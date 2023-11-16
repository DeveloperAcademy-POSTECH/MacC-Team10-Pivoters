//
//  SwiftDataManager.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

/// TODO: 이후에 TEAM으로 수정해야 함.
@MainActor
public let teamContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: RefactoredTeam.self)
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<RefactoredTeam>()).isEmpty {
            container.mainContext.insert(RefactoredTeam(id: UUID(),
                                                        teamName: "새 팀 1",
                                                        subTitle: "새 서브 타이틀",
                                                        isSelected: true,
                                                        createdAt: Date(),
                                                        updatedAt: Date()))
        }
        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()

public final class SwiftDataManager<T: PersistentModel> {

    private let modelContext: ModelContext

    @MainActor
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func insertItem(item: T) {
        modelContext.insert(item)
    }

    public func fetchItem() -> [T] {
        do {
            let items = try modelContext.fetch(FetchDescriptor<T>())
            return items
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func saveItems() {
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
