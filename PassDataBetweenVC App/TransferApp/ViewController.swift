

import UIKit

// (от B к A)
protocol UpdatableDataController: AnyObject {
    var updatedData: String { get set }
}


class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    
    var updatedData: String = "Test Data"
    @IBOutlet var dataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // (от B к A) с помощю Property
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    // 1. Вариант: передаём данные (от A к B) с помощю Property
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контролер, в который происходит переход (от А к B)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        
        // передаём данные к следующему экрану (от А к B) с помощю Property
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    
    // 2. Вариант: Обновляем данные в текстовой метке (от B к A) с помощю Property
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }
    
    // 3. Вариант: передаём данные с помощю Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    // 4. Вариант: передача данных от B к А с помощю unwind segue
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    
    // 5. Вариант: передача данных с помощю делегирования
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаём данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // 6. Вариант: передача данных от B к A с помощю замыкания
    // передача данных с помощю свойства и инициализация замыкания
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // передаём необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
        
    }
}

