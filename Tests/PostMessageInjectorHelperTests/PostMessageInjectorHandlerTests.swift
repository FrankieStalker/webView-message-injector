import Testing

import WebKit

import PostMessageInjectorHelper

@Suite
struct PostMessageInjectorHandlerTests {
    @MainActor
    @Test(
        "Given conditional webview, when Injecting Post Message, then handle postMessage and isOverlayPresented correctly",
        arguments: [
            (false, "foo", "foo", true, true),   // no webView
            (true,  "foo", "",   true, false)    // with webView
        ]
    )
    func test_whenInjectingPostMessage_thenHandleStateValues(
        _ hasWebView: Bool,
        _ postMessage: String,
        _ expectedPostMessageResult: String,
        _ isOverlayPresented: Bool,
        _ expectedIsOverlayPresentedResult: Bool
    ) {
        let state = PostMessageInjectorState()
        state.webView = hasWebView ? WKWebView(frame: .zero, configuration: WKWebViewConfiguration()) : nil
        state.postMessage = postMessage
        state.isOverlayPresented = isOverlayPresented
        
        let sut = createSut(with: state)
        sut.injectPostMessage()
        
        #expect(state.postMessage == expectedPostMessageResult)
        #expect(state.isOverlayPresented == expectedIsOverlayPresentedResult)
    }
    
    @Test(
        "When resetting state, then handle postMessage and isOverlayPresented correctly"
    )
    func test_whenResetingState_thenHandleStateValues() {
        let state = PostMessageInjectorState()
        state.postMessage = "postMessage"
        state.isOverlayPresented = true
        
        let sut = createSut(with: state)
        sut.reset()
        
        #expect(state.postMessage == "")
        #expect(state.isOverlayPresented == false)
    }
}

// MARK: - Helpers
extension PostMessageInjectorHandlerTests {
    private func createSut(with state: PostMessageInjectorState) -> PostMessageInjectorHandler {
        PostMessageInjectorHandler(state: state)
    }
}
