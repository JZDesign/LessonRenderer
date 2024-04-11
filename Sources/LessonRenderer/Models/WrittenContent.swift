import SwiftUI

public struct WrittenContent: Codable {
    public let content: String
    
    public init(content: String) {
        self.content = content
    }
    
    public func toMarkdown() -> LocalizedStringKey {
        .init(content)
    }
}
