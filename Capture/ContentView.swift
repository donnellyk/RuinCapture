import SwiftUI

struct ContentView: View {
  enum FocusField: Hashable {
    case field
  }
  
  enum Step : Hashable {
    case entry
    case refine
  }
  
  @AppStorage("ruin-filepath") var filepath: URL?
  @AppStorage("ruin-append") var stringAppend: String = ""
  @FocusState private var focusedField: FocusField?
  @State private var text: String = "### Hello There"
  @State private var step: Step = .entry
  
  var body: some View {
    ZStack {
      switch step {
      case .entry:
        VStack {
          TextEditor(text: $text)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .focused($focusedField, equals: .field)
            .task {
              focusedField = .field
            }
          HStack {
            Spacer()
            Button("⌘-Enter") {
              guard let url = filepath else { return }
              
              FileWriter.write(filepath: url, appendAfter: stringAppend, content: text)
//              step = .refine
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
