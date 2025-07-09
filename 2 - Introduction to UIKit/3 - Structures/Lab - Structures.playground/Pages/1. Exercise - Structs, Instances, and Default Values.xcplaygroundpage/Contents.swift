/*:
## Exercise - Structs, Instances, and Default Values
 
 Imagine you are creating an app that will monitor location. Create a `GPS` struct with two variable properties, `latitude` and `longitude`, both with default values of 0.0.
 */
struct GPS{
    var latitude:Double=0
    var longitude:Double=0
    func disp()
    {
        print("Latitude:",self.latitude,"Longitude:",self.longitude)
    }
    mutating func change(_ val1:Double,_ val2:Double)
    {
        self.latitude=val1;
        self.longitude=val2;
    }
}

//:  Create a variable instance of `GPS` called `somePlace`. It should be initialized without supplying any arguments. Print out the latitude and longitude of `somePlace`, which should be 0.0 for both.
var ok=GPS()
ok.disp()

//:  Change `somePlace`'s latitude to 51.514004, and the longitude to 0.125226, then print the updated values.
ok.change(51.514004,0.125226)
ok.disp()

//:  Now imagine you are making a social app for sharing your favorite books. Create a `Book` struct with four variable properties: `title`, `author`, `pages`, and `price`. The default values for both `title` and `author` should be an empty string. `pages` should default to 0, and `price` should default to 0.0.
struct Book{
    var title:String=" "
    var author:String=" "
    var pages:Int=0
    var price:Double=0.0
    func disp()
    {
        print("Title:",self.title,"Author:",self.author,"Pages:",self.pages,"Price:",self.price)
    }
    mutating func change(_ ok:String,_ ok1:String, _ pages:Int, _ price:Double)
    {
        title=ok;
        author=ok1
        self.pages=pages
        self.price=price
    }
}

//:  Create a variable instance of `Book` called `favoriteBook` without supplying any arguments. Print out the title of `favoriteBook`. Does it currently reflect the title of your favorite book? Probably not. Change all four properties of `favoriteBook` to reflect your favorite book. Then, using the properties of `favoriteBook`, print out facts about the book.
var favoriteBook=Book()
favoriteBook.change("OK","OK1",23,900)
favoriteBook.disp()



/*:
page 1 of 10  |  [Next: App Exercise - Workout Tracking](@next)
 */
