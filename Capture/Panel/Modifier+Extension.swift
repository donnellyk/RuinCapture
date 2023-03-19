import SwiftUI

fileprivate struct FloatingPanelModifier<PanelContent: View> : ViewModifier {
  @Binding var isPresented: Bool
  
  var contentRect: CGRect = CGRect(x: 0, y: 0, width: 624, height: 512)
  
  @ViewBuilder let view: () -> PanelContent
  
  @State var panel: FloatingPanel<PanelContent>? = nil
  
  func body(content: Content) -> some View {
    content
      .onAppear {
//        panel = FloatingPanel(view: view, contextRect: contentRect, isPresented: $isPresented)
//        panel?.center()
      }.onDisappear {
        panel?.close()
        panel = nil
      }.onChange(of: isPresented) { newValue in
        if newValue {
          present()
        } else {
          panel?.close()
        }
      }
  }
  
  func present() {
    panel?.orderFront(nil)
    panel?.makeKey()
  }
}

extension View {
  func floatingPanel<Content: View>(isPresented: Binding<Bool>,
                                    contentRect: CGRect = CGRect(x: 0, y: 0, width: 624, height: 512),
                                    @ViewBuilder content: @escaping () -> Content) -> some View {
    self.modifier(FloatingPanelModifier(isPresented: isPresented, contentRect: contentRect, view: content))
  }
}
