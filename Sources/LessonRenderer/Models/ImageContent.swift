import SwiftUI

public struct ImageContent: Codable, Equatable {
    public let imageUrl: URL
    public let details: String

    public init(url: URL, details: String) {
        self.imageUrl = url
        self.details = details
    }
    
    public func detailsMarkdown() -> LocalizedStringKey {
        .init(details)
    }
}
