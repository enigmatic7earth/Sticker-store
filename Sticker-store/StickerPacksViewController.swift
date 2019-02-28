//
//  ViewController.swift
//  Sticker-store
//
//  Created by NETBIZ on 27/02/19.
//  Copyright © 2019 Netbiz.in. All rights reserved.
//

import UIKit

class StickerPacksViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    private var needsFetchStickerPacks = true
    private var stickerPacks: [StickerPack] = []
    private var selectedIndex: IndexPath?

    // MARK: Outlets
    @IBOutlet private weak var stickersPackTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0;
        stickersPackTableView.register(UINib(nibName: "PackTableViewCell", bundle: nil), forCellReuseIdentifier: "StickerPackCell")
        stickersPackTableView.tableFooterView = UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndex = self.selectedIndex {
            stickersPackTableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needsFetchStickerPacks {
            //            let alert: UIAlertController = UIAlertController(title: "Don't ship this sample app!", message: "If you want to ship your sticker packs to the App Store, create your own app with its own user interface. Your app must have minimum to no resemblance to this sample app.", preferredStyle: .alert)
            //            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            //                self.needsFetchStickerPacks = false
            //                self.fetchStickerPacks()
            //            }))
            //            present(alert, animated: true, completion:nil)
            self.needsFetchStickerPacks = false
            self.fetchStickerPacks()
        }
    }
    
    private func fetchStickerPacks() {
        let loadingAlert: UIAlertController = UIAlertController(title: "Loading sticker packs", message: "\n\n", preferredStyle: .alert)
        loadingAlert.addSpinner()
        present(loadingAlert, animated: true, completion: nil)
        
        do {
            try StickerPackManager.fetchStickerPacks(fromJSON: StickerPackManager.stickersJSON(contentsOfFile: "sticker_packs")) { stickerPacks in
                loadingAlert.dismiss(animated: false, completion: {
                    self.navigationController?.navigationBar.alpha = 1.0;
                    
                    if stickerPacks.count > 1 {
                        self.stickerPacks = stickerPacks
                        self.stickersPackTableView.reloadData()
                    } else {
                        self.show(stickerPack: stickerPacks[0], animated: false)
                    }
                })
            }
        } catch StickerPackError.fileNotFound {
            fatalError("sticker_packs.wasticker not found.")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    private func show(stickerPack: StickerPack, animated: Bool) {
        // "stickerPackNotAnimated" still animates the push transition on iOS 8 and earlier.
        let identifier = animated ? "stickerPackAnimated" : "stickerPackNotAnimated"
        performSegue(withIdentifier: identifier, sender: stickerPack)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationBar = navigationController?.navigationBar {
            let contentInset: UIEdgeInsets = {
                if #available(iOS 11.0, *) {
                    return scrollView.adjustedContentInset
                } else {
                    return scrollView.contentInset
                }
            }()
            if scrollView.contentOffset.y <= -contentInset.top {
                navigationBar.shadowImage = UIImage()
            } else {
                navigationBar.shadowImage = nil
            }
        }
    }
    
    @objc func addButtonTapped(button: UIButton) {
        let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "", preferredStyle: .alert)
        loadingAlert.addSpinner()
        present(loadingAlert, animated: true, completion: nil)
        
        stickerPacks[button.tag].sendToWhatsApp { completed in
            loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickerPacks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StickerPackCell") as! PackTableViewCell
        cell.stickerPack = stickerPacks[indexPath.row]
        
        let addButton: UIButton = UIButton(type: .contactAdd)
        addButton.tag = indexPath.row
        addButton.isEnabled = Interoperability.canSend()
        addButton.addTarget(self, action: #selector(addButtonTapped(button:)), for: .touchUpInside)
        cell.accessoryView = addButton
        
        return cell
    }


}

