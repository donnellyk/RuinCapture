import SwiftUI
import SwiftDown

struct ContentView: View {
  enum FocusField: Hashable {
    case field
  }
  
  enum Step : Hashable {
    case entry
    case refine
  }
  
  @FocusState private var focusedField: FocusField?
  @State private var text: String = "### Hello There"
  @State private var step: Step = .entry
  
  var body: some View {
    ZStack {
      switch step {
      case .entry:
        VStack {
          SwiftDownEditor(text: $text)
            .insetsSize(10)
            .theme(Theme.BuiltIn.defaultLight.theme())
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .focused($focusedField, equals: .field)
            .task {
              focusedField = .field
            }
          HStack {
            Spacer()
            Button("⌘-Enter") {
              step = .refine
            }
            .keyboardShortcut(.return)
            .buttonStyle(.plain)
          }
        }
        .padding(10)
      case .refine:
        Text(text)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
