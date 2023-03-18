import UIKit

class InformationViewController: UIViewController {
    
    lazy var alertButton: CustomButton = {
        var button = CustomButton(vc: self,
                                  text: "Внимание",
                                  backgroundColor: .gray,
                                  backgroundImage: nil,
                                  tag: nil,
                                  shadow: false,
                                  tapAction: alert)
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var labelJSONFirst : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelJSONSecond : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        labelJSONFirst.translatesAutoresizingMaskIntoConstraints = false
        labelJSONSecond.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(alertButton)
        view.addSubview(labelJSONFirst)
        view.addSubview(labelJSONSecond)

        setJSONlabelFirst()
        setJSONlabelSecond()
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 100),
            alertButton.widthAnchor.constraint(equalToConstant: 200),
            alertButton.heightAnchor.constraint(equalToConstant: 60),
            labelJSONFirst.widthAnchor.constraint(equalToConstant: 200),
            labelJSONFirst.heightAnchor.constraint(equalToConstant: 100),
            labelJSONFirst.bottomAnchor.constraint(equalTo: labelJSONSecond.topAnchor, constant: 0),
            labelJSONFirst.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            labelJSONSecond.widthAnchor.constraint(equalToConstant: 200),
            labelJSONSecond.heightAnchor.constraint(equalToConstant: 100),
            labelJSONSecond.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -25),
            labelJSONSecond.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
        
    }
    
    func setJSONlabelFirst() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let JSONFirst = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        if let dict = JSONFirst as? [[String : Any]] {
                            DispatchQueue.main.async {
                                self.labelJSONFirst.text = "Рандомная фраза на латинском:\n \(dict.randomElement()!["title"]! as! String)"
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func setJSONlabelSecond() {
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let JSONSecond = try JSONDecoder().decode(JSONSecond.self, from: unwrappedData)
                        DispatchQueue.main.async {
                            self.labelJSONSecond.text = "Расстояние до Татуина:\n\(JSONSecond.orbitalPeriod)\nЧего именно \(JSONSecond.orbitalPeriod) - хз"
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    let alert = {(vc: UIViewController, sender: CustomButton) in
        
        
        let alert = UIAlertController(title: "Тревожное сообщение", message: "При отправке запроса произошла ошибка", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction (title: "FirstAlertAction", style: .default) {_ in print ("First Alert Action")}
        let secondAlertAction = UIAlertAction (title: "SecondAlertAction", style: .default) {_ in print ("Second Alert Action")}
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        vc.present(alert, animated: true, completion: nil)
    }
}
