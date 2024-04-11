import SwiftUI

public struct Lesson: Codable, Identifiable {
    public let id: UUID
    public let title: String
    public let activities: [Activity]
    
    public init(id: UUID, title: String, activities: [Activity]) {
        self.id = id
        self.title = title
        self.activities = activities
    }
}
