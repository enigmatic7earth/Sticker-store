//
//  PackCreatorVController.swift
//  Sticker-store
//
//  Created by NETBIZ on 27/02/19.
//  Copyright © 2019 Netbiz.in. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

let minStickerCount = 3
let maxStickerCount = 30
let interimSpacing: CGFloat = 10
let numberOfColumns: CGFloat = 3
let screenRect = UIScreen.main.bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height

class PackCreatorVController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var packCollectionView: UICollectionView!
    @IBOutlet weak var stickerLogoButton: UIButton!
    
    // MARK : Member variables
    private let cellLength: CGFloat = (screenWidth / numberOfColumns) - (interimSpacing * 2)
    var selectImageFor: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        packCollectionView.delegate = self
        packCollectionView.dataSource = self
        requestUserPermission()
    }
    
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
    
    @IBAction func selectPackIcon(_ sender: UIButton) {
        selectImage(forImageType: "iconPack")
        
    }
    
    @IBAction func savePack(_ sender: Any) {
        //last step: dismiss the controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestUserPermission(){
            
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    let permissionAlert = UIAlertController(title: "Success", message: "Thank you", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    permissionAlert.addAction(ok)
                    
                    self.present(permissionAlert, animated: true, completion: nil)
                    
                } else {
                    let permissionAlert = UIAlertController(title: "Error", message: "Please allow access", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    permissionAlert.addAction(ok)
                    self.present(permissionAlert, animated: true, completion: nil)
                }
            })

    }
    func selectImage(forImageType: String) {
        selectImageFor = forImageType
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension PackCreatorVController:UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interimSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellLength, height: cellLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxStickerCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundView?.backgroundColor = UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectImage()
        print("\(indexPath.row)")
    }
}

extension PackCreatorVController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        switch selectImageFor {
        case "iconPack":
            //iconPackImage
            stickerLogoButton.setImage(image, for: .normal)
        case "stickerPackItem":
            //stickerPackItem
            print("Cell")
        default:
            print("Error")
        }
        
        //imageView.image = image
    }
    
}
