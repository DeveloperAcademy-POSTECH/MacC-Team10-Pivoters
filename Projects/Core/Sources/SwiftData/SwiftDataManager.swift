//
//  SwiftDataManager.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

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
}
