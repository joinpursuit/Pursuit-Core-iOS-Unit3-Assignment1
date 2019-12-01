import UIKit

class UsersViewController: UIViewController {
    
    var users = [User]() {
        didSet {
            usersTableView.reloadData()
        }
    }
    
    @IBOutlet weak var usersTableView: UITableView!
    
    // SEARCH BAR
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    var searchedText = "" {
        didSet {
            usersTableView.reloadData()
        }
    }
    
    var filteredUsers: [User] {
        guard searchedText != "" else {
            return users
        }
        return users.filter{$0.name.fullName.lowercased().contains(searchedText.lowercased())}
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        userSearchBar.delegate = self
    }
    
    private func loadData() {
        guard let pathToJSON = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("Could not find JSON file")
        }
        let url = URL(fileURLWithPath: pathToJSON)
        
        do {
            let data = try Data(contentsOf: url)
            let usersFromJSON = User.getUsers(from: data)
            users = usersFromJSON
        } catch {
            fatalError("Count not get Users from Data!")
        }
        
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = filteredUsers[indexPath.row]
        
        cell.textLabel?.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        cell.detailTextLabel?.text = user.location.city.capitalized
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier on segue")
        }
        
        switch segueIdentifier {
        case "userDetail":
            
            guard let userDetail = segue.destination as? UserDetailViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = usersTableView.indexPathForSelectedRow else {
                fatalError("No row was selected")
            }
            userDetail.user = filteredUsers[selectedIndexPath.row]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = userSearchBar.text!
    }
}



