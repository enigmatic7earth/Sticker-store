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
    @IBAction func guidlinesInfo(_ sender: Any){
        
        let infoWindow = UIAlertController(title: "Sticker guidelines", message: "To create your own sticker art, your stickers must meet the following requirements:\n\t• Each sticker is an image that has a transparent background.\n\t• Stickers must be exactly 512x512 pixels.\n\t• Each sticker must be less than 100 KB.\nYou must also provide an icon that will be used to represent your sticker pack in the WhatsApp sticker picker or tray. This image should be 96x96 pixels and must be less than 50 KB.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let more = UIAlertAction(title: "More", style: .default) { (more) in
            // open web page: https://faq.whatsapp.com/general/26000226
            if let url = URL(string: "https://faq.whatsapp.com/general/26000226") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        infoWindow.addAction(ok)
        infoWindow.addAction(more)
        present(infoWindow, animated: true, completion: nil)
 
        
    }
    @IBAction func savePack(_ sender: Any) {
        
        
        
        //last step: dismiss the controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
