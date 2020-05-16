import Foundation
import SwiftUI
import Atributika

struct TextLabel: UIViewRepresentable {
    var text: String
//    let maxWidth: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let l = UILabel()
        l.numberOfLines = 20
        l.lineBreakMode = .byWordWrapping
        
        l.font = .preferredFont(forTextStyle: .body)
        return l
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        let linkStyle = Style("a").foregroundColor(.link, .normal)//.foregroundColor(.brown, .highlighted)
        uiView.setContentHuggingPriority(.defaultLow, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        let b = Style("b").font(UIFont.systemFont(ofSize: 20, weight: .bold)).foregroundColor(.black)
        uiView.attributedText = text
            .style(tags: b)
        .styleLinks(linkStyle)
            .attributedString

        uiView.layoutIfNeeded()
    }
}

struct TextLabel_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "<p>hello world</p>")
            .previewLayout(.sizeThatFits)
    }
}
