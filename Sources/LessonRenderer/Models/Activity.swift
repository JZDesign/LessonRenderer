import SwiftUI

public enum Activity: Codable, Equatable {
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
    
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        switch (lhs, rhs) {
        case (.image(let image1), .image(let image2)):
            return image1 == image2
        case (.video(let video1), .video(let video2)):
            return video1 == video2
        case (.audio(let audio1), .audio(let audio2)):
            return audio1 == audio2
        case (.read(let read1), .read(let read2)):
            return read1 == read2
        case (.sectionHeading(let sectionHeading1), .sectionHeading(let sectionHeading2)):
            return sectionHeading1 == sectionHeading2
        default:
            break
        }
        return false
    }
}

public struct InvalidContentType: Error {
    let message = "The received content could not be decoded"
}
