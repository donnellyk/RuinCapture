import SwiftUI

private struct FloatingPanelKey: EnvironmentKey {
  static let defaultValue: NSPanel? = nil
}

extension EnvironmentValues {
  var floatingPanel: NSPanel? {
    get { self[FloatingPanelKey.self] }
    set { self[FloatingPanelKey.self] = newValue }
  }
}

class FloatingPanel<Content: View>: NSPanel {
//  @Binding var isPresented: Bool
  
  init(view: () -> Content, contextRect: NSRect, backing: NSWindow.BackingStoreType = .buffered, defer flag: Bool = false) {
//    self._isPresented = isPresented
    
    super.init(contentRect: contextRect,
               styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView],
               backing: backing,
               defer: flag)
    
    isFloatingPanel = true
    level = .floating
    
    titleVisibility = .hidden
    titlebarAppearsTransparent = true
    
    isMovableByWindowBackground = true
    
    hidesOnDeactivate = false // Might feel wrong, we shall see...
    
    standardWindowButton(.closeButton)?.isHidden = true
    standardWindowButton(.miniaturizeButton)?.isHidden = true
    standardWindowButton(.zoomButton)?.isHidden = true
    
    animationBehavior = .utilityWindow
    
    contentView = NSHostingView(rootView: view()
      .ignoresSafeArea()
      .environment(\.floatingPanel, self))
  }
  
  override func resignMain() {
    super.resignMain()
    close()
  }
  
  override func close() {
    super.close()
//    isPresented = false
  }
  
  override var canBecomeKey: Bool {
    return true
  }
  
  override var canBecomeMain: Bool {
    return true
  }
}
