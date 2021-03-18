//
//  utils.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 3/7/21.
//

import Foundation

public func documentDirectory() -> String {
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return documentDirectory[0]
}

public func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
    if var pathURL = URL(string: path) {
        pathURL.appendPathComponent(pathComponent)
        return pathURL.absoluteString
    }
    return nil
}

public func read(fromDocumentsWithFileName fileName: String)  -> String? {
    guard let filePath = append(toPath: documentDirectory(), withPathComponent: fileName) else {
        return nil
    }
    do {
        let savedString = try String(contentsOfFile: filePath)
        return savedString
    } catch {
        print("Error reading saved file")
    }
    return nil
}

public func save(text: String, toDirectory directory: String, withFileName fileName: String) {
    guard let filePath = append(toPath: directory, withPathComponent: fileName) else {
        return
    }
    do {
        try text.write(toFile: filePath, atomically: true, encoding: .utf8)
    } catch {
        print("Error", error)
        return
    }
    print("Save successful")
}

public func saveToExistingFile(text: String, withFileName fileName: String) {
    guard let existingData = read(fromDocumentsWithFileName: fileName) else {
        return
    }
    let newText = existingData + text
    save(text: newText, toDirectory: documentDirectory(), withFileName: fileName)
}
