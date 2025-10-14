import SwiftUI

public struct PostMessageInjectorSheetView: View {
    @ObservedObject private var state: PostMessageInjectorState
    
    private var handler: PostMessageInjectorHandler {
        PostMessageInjectorHandler(state: state)
    }
    
    public init(state: PostMessageInjectorState) {
        self.state = state
    }
    
    public var body: some View {
        VStack {
            textField
            sendPostMessageButton
        }
        .padding(24)
        .background(background)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.horizontal, 8)
    }
    
    private var textField: some View {
        TextField(
            "post message to inject",
            text: $state.postMessage
        )
        .textInputAutocapitalization(.never)
    }
    
    private var sendPostMessageButton: some View {
        Button {
            withAnimation(.spring()) {
                handler.injectPostMessage()
            }
        } label: {
            sendPostMessageButtonLabel
        }
        .buttonStyle(.borderedProminent)
        .disabled(state.postMessage.isEmpty)
    }
    
    private var sendPostMessageButtonLabel: some View {
        Text("Send Post Message")
    }
}
