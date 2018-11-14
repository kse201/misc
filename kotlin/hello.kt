class Person (var name: String = "default name", var age: Int = 0){

    fun show () {
        println("私は${this.name}です。${this.age}歳です。")
    }
}
class Greeter(val name : String) {
    fun greet() {
        println("Hello, $name");
    }
}

fun main(args : Array<String>) {
    /* Greeter(args[0]).greet() */
    Greeter("foo").greet()

    var foo = Person("foo", 20)
    foo.show()

    val bar = Person(age = 10)
    bar.show()
}
