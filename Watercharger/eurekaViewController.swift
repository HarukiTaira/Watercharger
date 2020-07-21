//
//  eurekaViewController.swift
//  Watercharger
//
//  Created by 平良悠貴 on 2020/07/21.
//  Copyright © 2020 平良悠貴. All rights reserved.
//

import UIKit
import Eureka

class eurekaViewController: FormViewController {
    
    var ml : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }.onChange({ row in
                print(row.value as Any)
            })
            
            <<< TextRow{row in
                row.title = "量(ml)"
                row.placeholder = String(ml)
            }
            
            // ここからセクション2のコード
            +++ Section("その他")
        
        <<< TextRow{row in
            
            row.title = "日にち"
            row.placeholder = "今日の日にち"
        }
            <<< TextRow{row in
                row.title = "時間"
                row.placeholder = "写真を撮った時間"
        }
            
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
