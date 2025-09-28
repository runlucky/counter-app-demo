import SwiftUI
import SwiftData

@main
struct counterApp: App {
    var body: some Scene {
        WindowGroup {
            ItemListView()
        }
        .modelContainer(for: Item.self)
    }
}
