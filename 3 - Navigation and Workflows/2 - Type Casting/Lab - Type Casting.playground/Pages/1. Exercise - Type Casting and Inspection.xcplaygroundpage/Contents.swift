/*:
## Exercise - Type Casting and Inspection

 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
var ok:[Any]=[10,"Shubham",32.00,true]
for i in ok
{
    print(i)
}

//:  Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
for i in ok{
    if let p=i as? Int{
        print("The integer has a value of:",p)
    }
    else if let k=i as? String{
        print("The String Value is:",k)
    }
    else if let o=i  as? Double{
        print("The Double Value is:",o)
    }
    else if let k3=i as? Bool{
        print("The Bool Value is:",k3)
    }
}

//:  Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
var dict:[String:Any]=["Shubham":23,"Ok":34.00,"Thanks":true,"Welcome":"Here"]
for (ok,ok1) in dict{
    print("Key:",ok,"Value:",ok1)
}
//:  Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
var total:Double=0
for (ok,ok1) in dict{
    if let k=ok1 as? Int{
        total+=Double(k)
    }
    else if let k1=ok1 as? Double{
        total+=k1
    }
    else if let ok2=ok1 as? String{
        total+=1
    }
    else if let ok3=ok1 as? Bool{
        if ok3 == true{
            total+=2
        }
        else
        {
            total-=3
        }
    }
}
print(total)

//:  Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
var total2:Double = 0
for (i,j) in dict{
    if let k=j as? Int{
        total2+=Double(k)
    }
    else if let k1=j as? Double{
        total2+=k1
    }
    else if let k2=j as? String{
        if let k3=Int(k2)
        {
            total2+=Double(k3)
        }
    }
}
print("Total2:",total2)

/*:
page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
 */
