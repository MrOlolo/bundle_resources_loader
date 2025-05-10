import Flutter
import Foundation
import UIKit
import os

public class BundleResourcesLoaderPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "bundle_resources_loader",
            binaryMessenger: registrar.messenger())
        let instance = BundleResourcesLoaderPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(
        _ call: FlutterMethodCall, result: @escaping FlutterResult
    ) {
        switch call.method {
        case "searchResources":
            let args = call.arguments as? [String: Any]

            let filename = args?["filename"] as? String
            let fileExt = args?["extension"] as? String

            do {
                let files = try searchFilesRecursively(
                    withExtension: fileExt, filenameContains: filename)
                result(files)
            } catch {
                result(
                    FlutterError(
                        code: "SEARCH_ERROR", message: "Failed to search files",
                        details: error.localizedDescription))
            }

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func searchFilesRecursively(
        in bundle: Bundle = .main,
        withExtension fileExtension: String? = nil,
        filenameContains: String? = nil
    ) throws -> [String] {
        guard let resourcePath = bundle.resourcePath else {
            return []
        }

        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: resourcePath)
        var matchedFiles: [String] = []

        while let element = enumerator?.nextObject() as? String {
            let fullPath = (resourcePath as NSString).appendingPathComponent(
                element)
            var isDir: ObjCBool = false
            if fileManager.fileExists(atPath: fullPath, isDirectory: &isDir),
                !isDir.boolValue
            {
                let fileName = (element as NSString).lastPathComponent

                let extMatches =
                    fileExtension == nil
                    || (fileName as NSString).pathExtension == fileExtension
                let nameMatches =
                    filenameContains == nil
                    || fileName.contains(filenameContains!)

                if extMatches && nameMatches {
                    matchedFiles.append(fullPath)
                }
            }
        }

        return matchedFiles
    }
}
