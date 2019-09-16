import UIKit

class StockDetailViewController: UIViewController {
    var stock: Stock!
    
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var openingOutlet: UILabel!
    @IBOutlet weak var closingOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor()
        dateOutlet.text = "\(stock.date)"
        imageOutlet.image = UIImage(named: generateImage())
        openingOutlet.text = "Opening $\(stock.opening)"
        closingOutlet.text = "Closing $\(stock.closing)"
        
    }
    
    func generateImage() -> String {
        if stock.closing < stock.opening {
            return "thumbsDown"
        } else {
            return "thumbsUp"
        }
    }
    
    func backgroundColor() {
        if stock.closing < stock.opening {
            self.view.backgroundColor = .red
        } else {
            self.view.backgroundColor = .green
        }
    }

}
