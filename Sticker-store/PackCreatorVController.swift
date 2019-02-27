//
//  PackCreatorVController.swift
//  Sticker-store
//
//  Created by NETBIZ on 27/02/19.
//  Copyright © 2019 Netbiz.in. All rights reserved.
//

import UIKit

class PackCreatorVController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func savePack(_ sender: Any) {
        
        
        
        //last step: dismiss the controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
