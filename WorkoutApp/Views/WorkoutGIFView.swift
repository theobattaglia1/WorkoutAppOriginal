import SwiftUI
import WebKit

struct WorkoutGIFView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.scrollView.isScrollEnabled = false
        uiView.load(request)
    }
}
