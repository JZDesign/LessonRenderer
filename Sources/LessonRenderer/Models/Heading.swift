import SwiftUI

public struct Heading: Codable {
    public let heading: String
    public let size: Size

    public init(heading: String, size: Size) {
        self.heading = heading
        self.size = size
    }
    
    public enum Size: String, Codable {
        case small, medium, large, xlarge
    }
    
    public func toMarkdown() -> LocalizedStringKey {
        .init(heading)
    }
    
    @ViewBuilder
    public func toHeaderView() -> some View {
        switch size {
        case .small:
            Text(toMarkdown())
                .font(.title3)
        case .medium:
            Text(toMarkdown())
                .font(.title2)
        case .large:
            Text(toMarkdown())
                .font(.title)
        case .xlarge:
            Text(toMarkdown())
                .font(.largeTitle)
        }
    }
}
