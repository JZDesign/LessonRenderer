import SwiftUI

public struct AudioContent: Codable, Equatable {
    public let audioUrl: URL
    public let transcription: String
    public let shouldAutoPlay: Bool

    public init(url: URL, transcription: String, shouldAutoPlay: Bool) {
        self.audioUrl = url
        self.transcription = transcription
        self.shouldAutoPlay = shouldAutoPlay
    }
    
    public func transcrptionMarkdown() -> LocalizedStringKey {
        .init(transcription)
    }
}
