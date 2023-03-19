import SwiftUI
import HotKey

@main
struct CaptureApp: App {
  let hotKey: HotKey
  
  
  init() {
    hotKey = HotKey(key: .r, modifiers: [.command, .shift])
    
    hotKey.keyDownHandler = {
      PanelHelper.shared.showIfNeeded()
    }
  }
  
  var body: some Scene {
    MenuBarExtra("Ruin", systemImage: "0.circle.fill") {
      Button("New...") {
        PanelHelper.shared.showIfNeeded()
      }
    }
    Settings {
      SettingsView()
    }
  }
}

class PanelHelper {
  static var shared = PanelHelper()
  
  private init() { }
  
  func showIfNeeded() {
    
    let panel = FloatingPanel(view: {
      ContentView()
        .edgesIgnoringSafeArea(.top)
    }, contextRect: CGRect(x: 0, y: 0, width: 624, height: 512))
    
    panel.center()
    panel.orderFront(nil)
    panel.makeKey()
    
  }
}
