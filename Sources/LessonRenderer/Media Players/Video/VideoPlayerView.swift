import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer
    let shouldPlayImmediately: Bool
    
    init(url: URL, shouldPlayImmediately: Bool) {
        self.player = AVPlayer(url: url)
        self.shouldPlayImmediately = shouldPlayImmediately
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        if shouldPlayImmediately {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                controller.player?.play()
            }
        }
        controller.showsPlaybackControls = true
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}
