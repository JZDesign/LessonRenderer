import SwiftUI
import AVFoundation
// Modified from: https://github.com/ChrisMash/AVPlayer-SwiftUI

struct AudioPlayerControlsView: View {
    
    let player: AVPlayer
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let shouldPlayAutomatically: Bool
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    @State private var state = PlaybackState.paused
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    if state == .playing  {
                        player.pause()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.state = .paused
                        }
                    } else {
                        player.play()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.state = .playing
                        }
                    }
                }, label: {
                    Image(systemName: state == .playing ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .accessibilityLabel(state == .playing ? Text("Pause") : Text("Play"))
                })
                
                Spacer()
            }
            
            Slider(value: $currentTime,
                   in: 0...currentDuration,
                   onEditingChanged: sliderEditingChanged,
                   minimumValueLabel: Text("\(Utility.formatSecondsToHMS(currentTime))"),
                   maximumValueLabel: Text("\(Utility.formatSecondsToHMS(currentDuration))")) {
                Text("\(currentTime.rounded())")
            }
            .disabled(state != .playing)
        }
        .padding()
        .onReceive(timeObserver.publisher) { time in
            self.currentTime = time
            if time > 0 && state != .playing {
                self.state = .playing
            }
        }
        .onReceive(durationObserver.publisher) { duration in
            self.currentDuration = duration
        }
        .onAppear {
            if shouldPlayAutomatically {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    player.play()
                }
            }
        }
    }
    
    // MARK: Private functions
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            timeObserver.pause(true)
        }
        else {
            state = .buffering
            let targetTime = CMTime(seconds: currentTime, preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                self.timeObserver.pause(false)
                self.state = .playing
            }
        }
    }
}

enum Utility {
    private static var timeHMSFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    static func formatSecondsToHMS(_ seconds: Double) -> String {
        guard !seconds.isNaN,
            let text = timeHMSFormatter.string(from: seconds) else {
                return "00:00"
        }
         
        return text
    }
    
}

private enum PlaybackState: Int {
    case paused
    case buffering
    case playing
}
