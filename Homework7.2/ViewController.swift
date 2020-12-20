//
//  ViewController.swift
//  Homework7.2
//
//  Created by Stas on 20.12.2020.
//

import UIKit
import Alamofire
import RealmSwift
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var imagePlace: UIImageView!
    var index = -1
    let realm = try! Realm()
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var randButton: UIButton!
    
    let URlAddress: [String] = ["https://www.themealdb.com//images//media//meals//w8umt11583268117.jpg", "https://www.themealdb.com//images//media//meals//wqurxy1511453156.jpg", "https://www.themealdb.com//images//media//meals//rtwwvv1511799504.jpg", "https://www.themealdb.com//images//media//meals//q8sp3j1593349686.jpg" ,"https://www.themealdb.com//images//media//meals//rqvwxt1511384809.jpg"
        ,"https://www.themealdb.com//images//media//meals//ryppsv1511815505.jpg"
        ,"https://www.themealdb.com//images//media//meals//wrssvt1511556563.jpg"
        ,"https://www.themealdb.com//images//media//meals//sxxpst1468569714.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isHidden = true
    }


    @IBAction func randomize(_ sender: Any) {
        index = Int.random(in: 0..<8)
        var u = URlAddress[index]
        //загружается картинка с помощью alamofire
        AF.request( u,method: .get).response{ response in
            switch response.result {
                case .success(let responseData):
                    self.imagePlace.image = UIImage(data: responseData!, scale:1)

                case .failure(let error):
                    print("error--->",error)
            }
        }
        self.saveButton.isHidden = false
    }
    
    @IBAction func saving(_ sender: Any) {
        
        let objects = realm.objects(GetUrl.self)
        var obj = GetUrl(tmpurl: URlAddress[index])
        try! realm.write {
            realm.add(obj)
        }
        let objects1 = realm.objects(GetUrl.self)
        self.saveButton.isHidden = true
    }
    
    @IBAction func showSaved(_ sender: Any) {
        //выводит последнюю сохраненную картинку
        let objects = realm.objects(GetUrl.self)
        if objects.count != 0{
            var gUrl = URL(string: objects.last!.storedUrl)
            self.imagePlace.sd_setImage(with: gUrl)
        }
    }
}

