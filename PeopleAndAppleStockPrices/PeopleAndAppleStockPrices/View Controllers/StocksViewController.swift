import UIKit

class StocksViewController: UIViewController {
    
    var stocks = [Stock]()
    var sectionNames = [String]()
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStocksTableView()
        getStocks()
        getSectionNames()
    }
    
    private func configureStocksTableView() {
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
    }
    
    // generate and array of Stocks via local JSON file
    func getStocks() {
        guard let fileName = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError()
        }
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let stocksReceived = try JSONDecoder().decode([Stock].self, from: data)
            stocks = stocksReceived
        } catch {
            fatalError()
        }
    }
    
    // add all unique headers to the sectionNames array
    func getSectionNames() {
        for stock in stocks {
            if !sectionNames.contains(stock.header) {
                sectionNames.append(stock.header)
            }
        }
    }
    
    // sort each stock according to corresponding sectionNames.
    func stockBySection(sectionNumber: Int) -> [Stock] {
        return stocks.filter({$0.header == sectionNames[sectionNumber]})
    }
}

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySection(sectionNumber: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stockInSection = stockBySection(sectionNumber: indexPath.section)
        let stock = stockInSection[indexPath.row]
        
        cell.textLabel?.text = "\(stock.date)"
        cell.detailTextLabel?.text = "\(stock.opening)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier on segue")
        }
        
        switch segueIdentifier {
        case "StockDetail":
            
            guard let stockDetail = segue.destination as? StockDetailViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = stocksTableView.indexPathForSelectedRow else {
                fatalError("No row was selected")
            }
            stockDetail.stock = stocks[selectedIndexPath.row]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
}
