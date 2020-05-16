import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UITextView {
        let tv = UITextView()
        tv.dataDetectorTypes = .link
        tv.isEditable = false
        tv.textColor = UIColor(named: "titleColor")
        tv.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tv.isScrollEnabled = false
        tv.textContainer.lineBreakMode = .byWordWrapping
        tv.translatesAutoresizingMaskIntoConstraints = false

        return tv
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            uiView.attributedText = self.text.convertHtml()
            uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            uiView.setContentCompressionResistancePriority(.required, for: .vertical)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "<p>hello world</p>")
            .previewLayout(.sizeThatFits)
    }
}

extension String {
    func convertHtml() -> NSMutableAttributedString {
        guard let data = data(using: .unicode) else { return NSMutableAttributedString() }
        if let attributedString = try? NSMutableAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes:nil) {
//            attributedString.addAttributes([NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 0, length: self.co))
            return attributedString
        } else {
            return NSMutableAttributedString()
        }
    }
}
