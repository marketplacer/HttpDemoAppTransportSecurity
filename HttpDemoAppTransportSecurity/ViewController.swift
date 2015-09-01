import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var resultLabel: UILabel!

  @IBAction func didTapLoadButton(sender: AnyObject) {
    resultLabel.text = ""
    load("http://evgenii.com/")

    load("https://www.bikeexchange.com.au/")
    load("https://www.bikeexchange.com.au/dbimages/bike/fn_large/342/102723342/popup/16voltagejr24.jpg")
  }
  
  private func load(url: String) {
    guard let nsUrl = NSURL(string: url) else { return }
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl) { [weak self] (data, response, error) in
      if error == nil {
        self?.log("Success: \(url)")
      } else {
        self?.log("Error: \(url)")
      }
    }
    
    task.resume()
  }
  
  private func log(text: String) {
    dispatch_async(dispatch_get_main_queue()) { [weak self] in
      var outputText = self?.resultLabel.text ?? ""
      outputText += "\(text)\n\n"
      self?.resultLabel.text = outputText
    }
  }
}

