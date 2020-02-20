import UIKit

var str = "Hello, playground"
let x = str.prefix(3)
x.components(separatedBy: "e")

let arr = [1,2,3,4,5,6]
var arrArr: [[Int]]

func groupElements(arr: [Int]) -> [[Int]] {
    var newArr = [[Int]]()
    for num in arr {
        newArr.append([num])
    }
    
    return newArr
}
let singers = ["Ed Sheeran", "Ariana Grande", "Taylor Swift", "Adele Adkins"]
let groupedByLength = Dictionary(grouping: singers) { $0.count }
print(groupedByLength)
print(groupElements(arr: arr))
print(Dictionary(grouping: arr){$0})
let y = Array(groupedByLength.values)
print(y)
