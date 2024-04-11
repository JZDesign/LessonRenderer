import SwiftUI

public enum Activity: Codable {
    case image(ImageContent)
    case video(VideoContent)
    case audio(AudioContent)
    case read(WrittenContent)
    case sectionHeading(Heading)

    public init(from decoder: Decoder) throws {
        if let read = try? WrittenContent(from: decoder) {
            self = .read(read)
        } else if let image = try? ImageContent(from: decoder) {
            self = .image(image)
        } else if let video = try? VideoContent(from: decoder) {
            self = .video(video)
        } else if let audio = try? AudioContent(from: decoder) {
            self = .audio(audio)
        } else if let heading = try? Heading(from: decoder) {
            self = .sectionHeading(heading)
        } else {
            throw InvalidContentType()
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .image(let image):
            try image.encode(to: encoder)
        case .video(let videoContent):
            try videoContent.encode(to: encoder)
        case .audio(let audioContent):
            try audioContent.encode(to: encoder)
        case .read(let writtenContent):
            try writtenContent.encode(to: encoder)
        case .sectionHeading(let heading):
            try heading.encode(to: encoder)
        }
    }
}

public struct InvalidContentType: Error {
    let message = "The received content could not be decoded"
}
