import SwiftData

@Model
class Item2 {
    var name: String
    var checked: Bool
    var order: Int

    init(name: String, checked: Bool, order: Int) {
        self.name = name
        self.checked = checked
        self.order = order
    }
}
