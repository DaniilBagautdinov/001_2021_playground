
import Foundation


class Fraction {
    let name: String
    var students: [Student]
    let id: Int
    init(name: String, students: [Student], id: Int) {
        self.name = name
        self.students = students
        self.id = id
    }
}


enum Weapon: Int{
    case pen = 5
    case razor = 7
    case stone = 9
}

protocol Student : AnyObject {
    var hp: Int { get set }
    var weapon: Weapon? { get set }
    var damage: Int { get set }
    var chant: String { get }
    var name: String { get }
}

protocol Arena {
    var fraction1: Fraction { get set }
    var fraction2: Fraction { get set }
    
    func startBattle()
}



class HighLevelStudent: Student {
    var weapon: Weapon? {
        didSet {
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 20
    
    var damage: Int = 3
    
    let chant: String = "Я НЕ ПОПБЕДИМ!!!"
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleLevelStudent: Student {
    
    var weapon: Weapon? {
        didSet {
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 10
    
    var damage: Int = 2
    
    let chant: String = "БАТЯ В ЗДАНИИ!!!"
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}


class LowLevelStudent: Student {
    
    var weapon: Weapon? {
        didSet {
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 5
    
    var damage: Int = 1
    
    let chant: String = "ЧИКИРЯУ!!!"
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}


class Bully: Arena {
    var fraction1: Fraction
    
    var fraction2: Fraction
    
    init(fraction1: Fraction, fraction2: Fraction) {
        self.fraction1 = fraction1
        self.fraction2 = fraction2
    }
    
    func startBattle() {
    
        
        print("\nСтуденты разбежались, для того чтобы найти предметы, которые помогут им в схватке...")
        lootStage(fraction: fraction1)
        
        lootStage(fraction: fraction2)
        
        let looser = fightStage(fraction1: fraction1, fraction2: fraction2)
        var winner: Fraction
        if looser.id != fraction1.id {
            winner = fraction1
        } else {
            winner = fraction2
        }
        
        let randomAffected = Int.random(in: 2...winner.students.count-1)
        
        print("Победителем становится фракция под названием \(winner.name)!!! Они потеряли \(randomAffected) членов фракции")
        
        
    }
    
    func lootStage(fraction: Fraction) {
        print("\nФракция \(fraction.name) совместно ищет предметы")
        for student in fraction.students {
            
            let randomNumber = Int.random(in: 1...100)
            if randomNumber>70 {
                print("Кажется студент \(student.name) остался с пустыми руками. Кулаки в помощь!")
                student.weapon = nil
            } else if randomNumber>54 {
                print("Студент по имени \(student.name) смог найти ручку")
                student.weapon = .pen
            } else if randomNumber>38 {
                print("\(student.name) смог найти бритву. Похоже кому-то не поздоровится")
                student.weapon = .razor
            } else if randomNumber>20 {
                print("Вот он победитель, ему крупно повезло. \(student.name) нашел камень. Берегитесь его")
                student.weapon = .stone
            } else {
                print("Вы только посмотрите!!! №\(student.name) смог найти энергетик. Сейчас он востоновит все свои силы!")
                student.hp += 3
            }
            print(student.chant)
        }
    }
    
    func fightStage(fraction1: Fraction, fraction2: Fraction) -> Fraction {
        var losingFraction: Fraction = fraction1
        print("\nНачало битвы между двумя фракциями: \(fraction1.name) и \(fraction2.name)")
        
        let sumHP1 = sumHP(fraction: fraction1)
        let sumDmg1 = sumDmg(fraction: fraction1)
        let sumHP2 = sumHP(fraction: fraction2)
        let sumDmg2 = sumDmg(fraction: fraction2)
        
        if sumHP1==sumHP2 && sumDmg1>sumDmg2 {
            losingFraction = fraction2
        } else if sumHP1==sumHP2 && sumDmg1<sumDmg2 {
            losingFraction = fraction1
        } else if sumDmg1 == sumDmg2 && sumHP1>sumHP2 {
            losingFraction = fraction2
        } else if sumDmg1 == sumDmg2 && sumHP1<sumHP2 {
            losingFraction = fraction1
        } else if sumHP1>sumHP2 && sumDmg1>sumDmg2 {
            losingFraction = fraction2
        } else if sumHP1>sumHP2 && sumDmg1<sumDmg2 {
            let randomNumber = Int.random(in: 1...100)
            if randomNumber > 50 {
                losingFraction = fraction1
            } else {
                losingFraction = fraction2
            }
        } else if sumHP1<sumHP2 && sumDmg1>sumDmg2 {
            let randomNumber = Int.random(in: 1...100)
            if randomNumber > 50 {
                losingFraction = fraction2
            } else {
                losingFraction = fraction1
            }
        } else if sumHP1<sumHP2 && sumDmg1<sumDmg2 {
            losingFraction = fraction1
        }
        print("Фракция \(losingFraction.name) уничтожена и у нас определился победитель в этой схватке!\n")
        
        return losingFraction
    }
    
    func sumHP(fraction: Fraction) -> Int {
        var result:Int = 0
        for student in fraction.students {
            result += student.hp
        }
        
        return result
    }
    
    func sumDmg(fraction: Fraction) -> Int {
        var result:Int = 0
        for student in fraction.students {
            result += student.damage
        }
        
        return result
    }
    
}




var fraction1 = Fraction (name: "Акробаты", students: [HighLevelStudent (name: "Даня"), MiddleLevelStudent (name: "Саня"), MiddleLevelStudent (name: "Фаня"), LowLevelStudent (name: "Лера")], id: 1)
var fraction2 = Fraction (name: "Лесорубы", students: [HighLevelStudent (name: "Тыква"), MiddleLevelStudent (name: "Арбуз"), MiddleLevelStudent (name: "Шога"), LowLevelStudent (name: "Нина")], id: 2)
Bully (fraction1: fraction1, fraction2: fraction2).startBattle()
