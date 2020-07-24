//
//  eurekaViewController.swift
//  Watercharger
//
//  Created by 平良悠貴 on 2020/07/21.
//  Copyright © 2020 平良悠貴. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class eurekaViewController: FormViewController {
    
    var ml : Int! = 350
    
    let dt = Date()
    let dateFormatter_day = DateFormatter()
    let dateFormatter_time = DateFormatter()
    var select : String! = ""
    var youryou : String! = ""
    var time : String! = ""
    var month : String! = ""
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Do any additional setup after loading the view.
        
        form
            +++ Section() {
                $0.header = {
                    let header = HeaderFooterView<UIView>(.callback({
                        
                        let view = UIView()
                        view.frame = CGRect(x:((self.view.bounds.width-320)/2), y: 0, width: self.view.frame.width, height: 300)
                        
                        let image1 = UIImage(named: "水滴アイコン4.png")
                        let Resize : CGSize = CGSize.init(width: self.view.frame.width, height: 300)
                        let image2 = image1?.resize(size: Resize)
                        
                        let imageView = UIImageView(image: image2)
                        view.addSubview(imageView)
                        return view
                    }))
                    return header
                }()
            }
            +++ Section("情報")
            
            <<< AlertRow<String>(""){
                $0.title = "種類"
                $0.selectorTitle = "選択して下さい"
                $0.options = ["水","お茶","コーヒー","酒"]
                $0.value = "水"
                select = $0.value
            }.onChange({ row in
                self.select = row.value
            })
            
            <<< TextRow{row in
                row.title = "量(ml)"
                row.placeholder = String(ml)
                youryou = String(ml)
            }.onChange({row in
                self.youryou = row.value
            })
            
            // ここからセクション2のコード
            +++ Section("その他")
            
            <<< TextRow{row in
                
                dateFormatter_day.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMd", options: 0, locale: Locale(identifier: "ja_JP"))
                
                row.title = "日にち"
                row.placeholder = dateFormatter_day.string(from: dt)
                month = dateFormatter_day.string(from: dt)
            }.onChange({row in
                self.month = row.value
            })
            <<< TextRow{row in
                
                dateFormatter_time.dateFormat = DateFormatter.dateFormat(fromTemplate: "Hm", options: 0, locale: Locale(identifier: "ja_JP"))
                
                row.title = "時間"
                row.placeholder = dateFormatter_time.string(from: dt)
                time = dateFormatter_time.string(from: dt)
            }.onChange({row in
                self.time = row.value
            })
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print(select!)
        additemDetail(title: select!)
    }
    
    func additemDetail(title:String){
        let itemDetail_save = itemDetail.create()
        itemDetail_save.title = select!
        itemDetail_save.bottle = youryou!
        itemDetail_save.month = month!
        itemDetail_save.time = time!
        
        itemDetail_save.save()
    }
    
    
    
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

extension UIImage{
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
