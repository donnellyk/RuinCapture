import Foundation
import Markdown

struct FileWriter {
  static func write(filepath: URL, appendAfter: String, content: String) {
    guard let fileContents = readFile(filepath: filepath) else {
      print("Could not read file")
      return
    }
    
    let document = Document(parsing: fileContents)
    print(document.debugDescription())
  }
}

extension FileWriter {
  static func readFile(filepath: URL) -> String? {
    return try? String(contentsOf: filepath)
  }
}
