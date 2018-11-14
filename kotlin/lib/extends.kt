open class Person (var name: String = "default name", var age: Int = 0){
    open fun show () : String{
        return "私は${this.name}です。${this.age}歳です。"
    }
}

class BusinessPerson(name: String, var depart:  String): Person(name, 20) {
    override fun show() : String {
        return "私は${this.name}です。${this.age}歳です。"
    }
}
