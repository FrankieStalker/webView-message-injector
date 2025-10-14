public struct PostMessageInjectorHandler {
    private var state: PostMessageInjectorState
    
    public init(state: PostMessageInjectorState) {
        self.state = state
    }
    
    @MainActor
    public func injectPostMessage() {
        guard let webView = state.webView else { return }
        webView.evaluateJavaScript(state.postMessage)
        reset()
    }
    
    public func reset() {
        state.postMessage = ""
        state.isOverlayPresented = false
    }
}
