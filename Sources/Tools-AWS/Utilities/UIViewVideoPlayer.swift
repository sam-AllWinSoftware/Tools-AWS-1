import UIKit
import AVFoundation

final class UIViewVideoPlayer: UIView {
    
    var playerObserver: Any?
    var loopVideo: Bool = true
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    /// Player has `automaticallyWaitsToMinimizeStalling` enabled - a loading stage to allow for buffer build up should be accounted for.
    func playVideo(forResource: String, ofType: String) {
        guard let path = Bundle.main.path(forResource: forResource, ofType: ofType) else { return }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = layer as? AVPlayerLayer
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.player = player
        player.automaticallyWaitsToMinimizeStalling = true
        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                                object: player.currentItem,
                                                                queue: .main) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
        player.play()
    }
    
    deinit {
        guard let observer = playerObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
}
