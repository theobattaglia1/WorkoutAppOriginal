import Foundation

extension Bundle {
    var openAIAPIKey: String? {
        guard let url = self.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let key = plist["OpenAI_API_KEY"] as? String else {
            print("❌ Could not find OpenAI API key in Secrets.plist")
            return nil
        }
        return key
    }
}
