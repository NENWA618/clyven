import AVFoundation
import AVKit
import Flutter
import UIKit

/// Drives iOS picture-in-picture for the AVPlayerLayer that video_player
/// creates in platform-view mode. Flutter tells us when playback is eligible;
/// we bind an AVPictureInPictureController to the visible layer and let the
/// system start PiP automatically when the app goes to the background.
final class PipBridge: NSObject, AVPictureInPictureControllerDelegate {
  private let channel: FlutterMethodChannel
  private var controller: AVPictureInPictureController?
  private weak var boundLayer: AVPlayerLayer?
  private var eligible = false
  private var retries = 0

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "clyven/pip", binaryMessenger: messenger)
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { return }
      if call.method == "setEligible" {
        let args = call.arguments as? [String: Any]
        self.eligible = (args?["eligible"] as? Bool) ?? false
        self.retries = 0
        self.refresh()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    NotificationCenter.default.addObserver(
      self, selector: #selector(appWillResignActive),
      name: UIApplication.willResignActiveNotification, object: nil)
  }

  @objc private func appWillResignActive() {
    // The layer may have been recreated (e.g. after a rebuild); rebind before
    // the system decides whether to start PiP.
    if eligible { refresh() }
  }

  private func refresh() {
    guard eligible, AVPictureInPictureController.isPictureInPictureSupported() else {
      if !eligible { unbind() }
      return
    }

    guard let layer = findPlayerLayer() else {
      // The platform view may not be attached yet.
      if retries < 10 {
        retries += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
          self?.refresh()
        }
      }
      return
    }
    if layer === boundLayer, controller != nil { return }

    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
    try? AVAudioSession.sharedInstance().setActive(true)

    let pip = AVPictureInPictureController(playerLayer: layer)
    pip?.delegate = self
    if #available(iOS 14.2, *) {
      pip?.canStartPictureInPictureAutomaticallyFromInline = true
    }
    controller = pip
    boundLayer = layer
  }

  private func unbind() {
    if #available(iOS 14.2, *) {
      controller?.canStartPictureInPictureAutomaticallyFromInline = false
    }
    controller = nil
    boundLayer = nil
  }

  /// Finds the largest on-screen AVPlayerLayer that is actually playing.
  private func findPlayerLayer() -> AVPlayerLayer? {
    var best: AVPlayerLayer?
    var bestArea: CGFloat = 0

    func visit(_ view: UIView) {
      if let layer = view.layer as? AVPlayerLayer,
        layer.player != nil, view.window != nil, !view.isHidden
      {
        let area = view.bounds.width * view.bounds.height
        if area > bestArea {
          best = layer
          bestArea = area
        }
      }
      view.subviews.forEach(visit)
    }

    for scene in UIApplication.shared.connectedScenes {
      guard let windowScene = scene as? UIWindowScene else { continue }
      windowScene.windows.forEach(visit)
    }
    return best
  }

  // MARK: AVPictureInPictureControllerDelegate

  func pictureInPictureControllerDidStartPictureInPicture(
    _ pictureInPictureController: AVPictureInPictureController
  ) {
    channel.invokeMethod("pipChanged", arguments: true)
  }

  func pictureInPictureControllerDidStopPictureInPicture(
    _ pictureInPictureController: AVPictureInPictureController
  ) {
    channel.invokeMethod("pipChanged", arguments: false)
  }

  func pictureInPictureController(
    _ pictureInPictureController: AVPictureInPictureController,
    restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler:
      @escaping (Bool) -> Void
  ) {
    completionHandler(true)
  }
}
