import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

var previousArray1 = [1, 2, 3, 4, 5]
var previousArray2 = [1, 2, 3, 4, 5]
let newArray = [1, 2, 3, 5]

extension Array {
    
    /**
     Reduces self to be the same array as input argument.
     Dose it without creating a new array, but making a set of mutating operations.
     
     - Parameters:
        - newData: New array that self must be reduced to.
        - comparator: Comparing closure that takes two objects of array elements type and returns Boolean result of comparing.
     
     - Complexity: N * (M + N), where N – number of items in initial array, M – number of items in array that initial array must be reduced to.
     */
    mutating func reduced(to newData: [Element],
                          comparator: (Element, Element) -> Bool) {
        var elementsToInsert = [Element]()
        var indicators = map { _ in false}
        
        for newElement in newData {
            var exists = false
            for (previousElementIndex, previousElement) in self.enumerated() {
                if comparator(newElement, previousElement) {
                    indicators[previousElementIndex] = true
                    exists = true
                }
            }
            
            if !exists {
                elementsToInsert.append(newElement)
            }
        }
        
        for (flagIndex, flag) in indicators.enumerated().reversed() {
            if !flag {
                remove(at: flagIndex)
            }
        }
        
        for elementToInsert in elementsToInsert {
            for (newElementIndex, newElement) in newData.enumerated()  {
                if comparator(elementToInsert, newElement) {
                    insert(elementToInsert, at: newElementIndex)
                }
            }
        }
    }
    
}

extension Array where Element: Equatable {
    
    /**
     Reduces self to be the same array as input argument.
     Dose it without creating a new array, but making a set of mutating operations.
     
     - parameter newData:
     New array that self must be reduced to.
     
     - Complexity: N * (M + N), where N – number of items in initial array, M – number of items in array that initial array must be reduced to.
     */
    mutating func reduced(to newData: [Element]) {
        reduced(to: newData, comparator: ==)
    }
    
}

previousArray1.reduced(to: newArray)
previousArray1.reduced(to: newArray) { $0 == $1 }
