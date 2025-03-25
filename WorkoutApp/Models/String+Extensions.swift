import Foundation
import UIKit

extension String {
    var htmlToText: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributed = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            return attributed.string
        } catch {
            return self
        }
    }
}
