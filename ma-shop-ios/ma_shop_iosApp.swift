//
//  ma_shop_iosApp.swift
//  ma-shop-ios
//
//  Created by Nick Sophinos on 3/6/23.
//

import SwiftUI

@main
struct ma_shop_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
