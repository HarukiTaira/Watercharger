//
//  ViewController.swift
//  Watercharger
//
//  Created by 平良悠貴 on 2020/07/19.
//  Copyright © 2020 平良悠貴. All rights reserved.
//

import UIKit
import WaveAnimationView
import Vision

class homeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var lapView : UIView!
    @IBOutlet weak var parsent: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var wave : WaveAnimationView!
    var waveParsent :Float!
    var parsentCalc :Int!
    
    let data = ["250","200"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
        
        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: lapView.bounds.size), color: UIColor.blue.withAlphaComponent(0.5))
        lapView.addSubview(wave)
        wave.maskImage = UIImage(named: "水滴アイコン4.png")
        wave.startAnimation()
        waveCalc(waveParsent: 0.7)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wave.stopAnimation()
    }
    
    func waveCalc(waveParsent:Float){
        wave.progress = waveParsent
        parsentCalc = Int(waveParsent * 100)
        parsent.text = String(parsentCalc)+"%"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.textLabel!.text = data[indexPath.row]
        return cell
    }
    
}

