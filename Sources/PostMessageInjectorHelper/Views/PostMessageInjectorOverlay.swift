import SwiftUI
import WebKit

public struct PostMessageInjectorOverlay: View {
    @ObservedObject private var state: PostMessageInjectorState
    
    private var handler: PostMessageInjectorHandler {
        PostMessageInjectorHandler(state: state)
    }
    
    public init(postMessageInjectorState: PostMessageInjectorState) {
        self.state = postMessageInjectorState
    }
    
    public var body: some View {
        if !state.isOverlayPresented {
            button
        } else {
            messageInjectorOverlay
        }
    }
    
    private var messageInjectorOverlay: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .ignoresSafeArea()
            PostMessageInjectorSheetView(state: state)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                handler.reset()
            }
        }
        .transition(.scale)
    }
    
    private var button: some View {
        Button {
            withAnimation(.spring()) {
                state.isOverlayPresented = true
            }
        } label: {
            buttonLabel
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .transition(.move(edge: .trailing))
    }
    
    private var buttonLabel: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.blue)
            .overlay { Image(systemName: "syringe").foregroundStyle(.white) }
            .frame(width: 44, height: 44)
    }
}
