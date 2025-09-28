import SwiftUI

struct ItemView2: View {
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

#Preview {
    ItemView(item: Item(name: "Sample Item", checked: true, order: 1))
}
