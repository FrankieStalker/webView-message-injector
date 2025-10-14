import SwiftUI
import WebKit

public class PostMessageInjectorState: ObservableObject {
    @Published public var isOverlayPresented = false
    @Published public var postMessage = ""
    weak public var webView: WKWebView?
    
    public init() {}
}
