import Foundation
import Markdown

struct FileWriter {
  static var currentDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, YYYY"
    
    return formatter.string(from: Date())
  }
  
  static func write(filepath: URL, appendAfter: String, content: String) {
    guard var fileContents = readFile(filepath: filepath) else {
      print("Could not read file")
      return
    }
    
    if fileContents.contains(currentDate) {
      var replacementString = currentDate + "\n" + content + "\n"
      fileContents = fileContents.replacingOccurrences(of: currentDate, with: replacementString)
    } else if fileContents.contains(appendAfter) {
      var replacementString = appendAfter + "\n" + content + "\n"
      fileContents = fileContents.replacingOccurrences(of: appendAfter, with: replacementString)
    } else {
      fileContents = content + "\n" + fileContents
    }
    
    do {
      try fileContents.write(toFile: filepath.path(), atomically: false, encoding: .utf8)
    } catch {
      print("Unexpected error: \(error).")
    }
  }
}

extension FileWriter {
  static func readFile(filepath: URL) -> String? {
    return try? String(contentsOf: filepath)
  }
}
