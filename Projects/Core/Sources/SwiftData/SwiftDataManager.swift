//
//  SwiftDataManager.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@MainActor
public let teamContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Team.self)
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Team>()).isEmpty {
            container.mainContext.insert(Team(id: UUID(), teamName: "새 팀 1", subTitle: "새 서브 타이틀", lineup: [
                /// Lineup 구현 3개 요구
            ]))
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

    public func fetchItem<V: PersistentModel>() -> [V]? {
        do {
            let items = try modelContext.fetch(FetchDescriptor<V>())
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
