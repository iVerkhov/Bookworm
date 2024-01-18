//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Игорь Верхов on 11.09.2023.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
