import SwiftUI

public struct VideoContent: Codable {
    public let videoUrl: URL
    public let transcription: String
    public let shouldAutoPlay: Bool
        
    public init(url: URL, transcription: String, shouldAutoPlay: Bool) {
        self.videoUrl = url
        self.transcription = transcription
        self.shouldAutoPlay = shouldAutoPlay
    }
    
    public func transcrptionMarkdown() -> LocalizedStringKey {
        .init(transcription)
    }
}
