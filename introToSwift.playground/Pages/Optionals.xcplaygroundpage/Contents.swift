// In Java world...

var str: String = "a String"
if str == nil {
    print("It's nil")
} else {
    print("It's not nil, it's " + str)
}

// In Swift world...

//str = nil

var strOrNil: String? = "a String"

// Force unwrapping.

print(strOrNil!)

// Optional Binding

if let str = strOrNil {
    print("It's not nil, it's " + str)
} else {
    print("It's nil")
}
