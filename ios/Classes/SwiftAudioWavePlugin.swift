import Flutter
import UIKit

public class SwiftAudioWavePlugin: NSObject, FlutterPlugin {
    
    final var audioWaveMethodCall = AudioWaveMethodCall()
    
    struct Constants {
        static let methodChannelName = "simform_audio_wave_plugin/methods"
        static let startRecording = "startRecording"
        static let pauseRecording = "pauseRecording"
        static let stopRecording = "stopRecording"
        static let getDecibel = "getDecibel"
        static let checkPermission = "checkPermission"
        static let path = "path"
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Constants.methodChannelName, binaryMessenger: registrar.messenger())
        let instance = SwiftAudioWavePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any>
        switch call.method {
        case Constants.startRecording:
            audioWaveMethodCall.startRecording(result,args?[Constants.path] as? String)
            break
        case Constants.pauseRecording:
            audioWaveMethodCall.pauseRecording(result)
            break
        case Constants.stopRecording:
            audioWaveMethodCall.stopRecording(result)
            break
        case Constants.getDecibel:
            audioWaveMethodCall.getDecibel(result)
            break
        case Constants.checkPermission:
            audioWaveMethodCall.checkHasPermission(result)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    
}