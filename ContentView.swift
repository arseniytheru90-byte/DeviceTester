import SwiftUI
import UIKit
import AudioToolbox
import AVFoundation

struct ContentView: View {

    @State private var flashOn = false

    var body: some View {

        ZStack {
            LinearGradient(colors: [.black, .blue, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 20) {

                Text("DEVICE TESTER")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                Button("ВИБРАЦИЯ") {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                }
                .buttonStyle(.borderedProminent)

                Button("ЗВУК") {
                    AudioServicesPlaySystemSound(1104)
                }
                .buttonStyle(.borderedProminent)

                Button("ФОНАРИК") {
                    toggleFlash()
                    flashOn.toggle()
                }
                .buttonStyle(.borderedProminent)

                Text("AltStore Build Ready")
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }

    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if device.torchMode == .off {
                try device.setTorchModeOn(level: 1.0)
            } else {
                device.torchMode = .off
            }

            device.unlockForConfiguration()
        } catch { }
    }
}
