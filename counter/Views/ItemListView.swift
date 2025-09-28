import SwiftUI
import SwiftData

struct ItemListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.order) private var items: [Item]
    @State private var text = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ItemView(item: item)
                }
                .onMove { source, destination in
                    moveItems(from: source, to: destination)
                }
                .onDelete { indexSet in
                    deleteItems(indexSet)
                }

                HStack {
                    TextField("input here", text: $text)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        addItem()
                    }
                    .disabled(text.isEmpty)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    
    func addItem() {
        let item = {
            let order = (items.map(\.order).max() ?? 0) + 1
            return Item(name: text, checked: false, order: order)
        }()

        context.insert(item)
        text = ""
    }

    func deleteItems(_ indexSet: IndexSet) {
        indexSet.forEach {
            context.delete(items[$0])
        }
    }

    func moveItems(from: IndexSet, to: Int) {
        var temp = items
        temp.move(fromOffsets: from, toOffset: to)
        
        temp.enumerated().forEach { index, item in
            item.order = index
        }
    }
}

struct ItemView: View {
    @Bindable var item: Item

    var body: some View {
        HStack {
            Text(item.order.description)
            TextField("Name", text: $item.name)
                .textFieldStyle(.roundedBorder)
            
            Toggle("", isOn: $item.checked)
                .labelsHidden()
        }
    }
}

@Model
class Item {
    var name: String
    var checked: Bool
    var order: Int

    init(name: String, checked: Bool, order: Int) {
        self.name = name
        self.checked = checked
        self.order = order
    }
}
