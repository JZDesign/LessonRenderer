import SwiftUI

public struct Lesson: Codable, Identifiable, Hashable, Equatable {
    public let id: UUID
    public let title: String
    public let activities: [Activity]
    
    public init(id: UUID, title: String, activities: [Activity]) {
        self.id = id
        self.title = title
        self.activities = activities
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(self.title)
    }
}
