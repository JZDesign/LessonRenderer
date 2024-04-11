import SwiftUI
import AVFoundation
// Modified from: https://github.com/ChrisMash/AVPlayer-SwiftUI

struct AudioView: View {
    let player = AVPlayer()
    let shouldPlayAutomatically: Bool
    
    init(url: URL, shouldPlayAutomatically: Bool) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        self.shouldPlayAutomatically = shouldPlayAutomatically
    }
    
    var body: some View {
        AudioPlayerControlsView(
            player: player,
            timeObserver: PlayerTimeObserver(player: player),
            durationObserver: PlayerDurationObserver(player: player),
            shouldPlayAutomatically: shouldPlayAutomatically
        )
    }
}
