import SwiftUI

struct SettingsView: View {
  @AppStorage("ruin-filepath") var filepath: URL?
  @AppStorage("ruin-append") var stringAppend: String = ""
  
  var body: some View {
    Form {
      Section {
        LabeledContent("File", value: filepath?.lastPathComponent ?? "None Selected")
        HStack {
          Spacer()
          Button("Select File")
          {
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = false
            panel.canChooseDirectories = false
            if panel.runModal() == .OK {
              self.filepath = panel.url
            }
          }
        }
        TextField("Append After", text: $stringAppend)
      }
    }
    .formStyle(.grouped)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
