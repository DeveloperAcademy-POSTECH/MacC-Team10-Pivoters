//
//  SwiftDataManager.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData



//@MainActor
//public let playerContainer: ModelContainer = {
//    do {
//        let container = try ModelContainer(for: Player.self)
//        return container
//    } catch {
//        fatalError(error.localizedDescription)
//    }
//}()

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
