import UIKit
import Flutter
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let videoConverterChannel = FlutterMethodChannel(name: "com.shivalay.cinemagicx/video_converter",
                                                         binaryMessenger: controller.binaryMessenger)
        
        videoConverterChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "convertTsToMp4" {
                guard let args = call.arguments as? [String: Any],
                      let inputFilePath = args["inputFilePath"] as? String,
                      let outputFilePath = args["outputFilePath"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
                    return
                }
                self?.convertTsToMp4(inputFilePath: inputFilePath, outputFilePath: outputFilePath, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func convertTsToMp4(inputFilePath: String, outputFilePath: String, result: @escaping FlutterResult) {
        let inputURL = URL(fileURLWithPath: inputFilePath)
        let outputURL = URL(fileURLWithPath: outputFilePath)
        
        let asset = AVAsset(url: inputURL)
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exportSession?.outputURL = outputURL
        exportSession?.outputFileType = .mp4
        exportSession?.shouldOptimizeForNetworkUse = true
        
        exportSession?.exportAsynchronously {
            switch exportSession?.status {
            case .completed:
                result(outputFilePath)
            case .failed:
                if let error = exportSession?.error {
                    result(FlutterError(code: "EXPORT_FAILED", message: error.localizedDescription, details: nil))
                }
            case .cancelled:
                result(FlutterError(code: "EXPORT_CANCELLED", message: "Export was cancelled", details: nil))
            default:
                result(FlutterError(code: "EXPORT_UNKNOWN", message: "Unknown export error", details: nil))
            }
        }
    }
}















// import Flutter
// import UIKit
// import AVFoundation

// func convertTsToMp4(tsFilePath: String, outputFilePath: String,   completion  : @escaping (Result<String, Error>) -> Void) {
//     let tsFileURL = URL(fileURLWithPath: tsFilePath)
//     let outputURL = URL(fileURLWithPath: outputFilePath)
//     let asset = AVAsset(url: tsFileURL)



//     let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)
//     exportSession?.outputFileType
//  = AVFileType.mp4


//     exportSession?.outputURL = outputURL



//     DispatchQueue.global(qos: .background).async {
//         exportSession!.exportAsynchronously(completionHandler: {
            
            
//             completion(.success(outputFilePath))
            
//         })
        

//     }




// }

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//     override func application(
//         _ application: UIApplication,
//         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//     ) -> Bool {
//         let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
//         let methodChannel = FlutterMethodChannel(name: "com.example.converter", binaryMessenger: controller.binaryMessenger)

//         methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
//             if call.method == "convertTsToMp4" {
//                 guard let args = call.arguments as? [String: String],
//                       let tsFilePath = args["inputPath"],
//                       let outputFilePath = args["outputPath"] else {
//                     result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
//                     return
//                 }
                
//                 convertTsToMp4(tsFilePath: tsFilePath, outputFilePath: outputFilePath) { conversionResult in
//                     switch conversionResult {
//                     case .success(let outputPath):
//                         result(outputPath)
//                     case .failure(let error):
//                         result(FlutterError(code: "CONVERSION_FAILED", message: error.localizedDescription, details: nil))
//                     }
//                 }
//             } else {
//                 result(FlutterMethodNotImplemented)
//             }
//         }
//         if #available(iOS 10.0, *) {
//             UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//         }
//         GeneratedPluginRegistrant.register(with: self)


//         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//     }
// }




