//
//  WinViewController.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam on 24/04/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {

    @IBOutlet weak var winStackView: WinStack!
    override func viewDidLoad() {
        super.viewDidLoad()

        winStackView.spacing = CGFloat()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
