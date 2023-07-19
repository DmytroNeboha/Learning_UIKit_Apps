
import UIKit

class ViewController: UIViewController {

    var game: Game!

    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!


    // MARK: - Жизненный цикл

    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        game = Game(valueGenerator: generator, rounds: 5)
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithScreenNumber(newText: String(game.currendRound.currentSecretValue))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    

    
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // высчитываем очки за раунд
        game.currendRound.calculateScore(with: Int(slider.value))
        // проверяем окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // Начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithScreenNumber(newText: String(game.currendRound.currentSecretValue))
    }


    // MARK: - Обновление View
    
    
    private func updateLabelWithScreenNumber(newText: String) {
        label.text = newText
    }
    
    // Отображать всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



// code
