//func ascendingEvenElements(of array: [Int]) -> [Int] {
//    var evenArray: [Int] = []
//    for integer in array {
//        if integer % 2 == 0 {
//            evenArray.append(integer)
//        }
//    }
//    return evenArray.sorted()
//}

func ascendingEvenElements(of array: [Int]) -> [Int] {
    return array.filter({ $0 % 2 == 0 }).sorted()
}

print(ascendingEvenElements(of: [3,6,4,2,7,9]))
