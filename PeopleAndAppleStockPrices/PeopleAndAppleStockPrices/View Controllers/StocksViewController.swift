import UIKit

class StocksViewController: UIViewController {
    
    var stocks = [Stock]()
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStocksTableView()
        getStocks()
    }
    
    private func configureStocksTableView() {
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
    }
    
    private func getStocks() {
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
    
}

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TO-DO"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stock = stocks[indexPath.row]
        
        cell.textLabel?.text = "\(stock.opening)"
        
        return cell
    }
    
    
}
