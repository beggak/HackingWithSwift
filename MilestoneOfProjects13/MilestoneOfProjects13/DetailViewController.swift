//
//  DetailViewController.swift
//  MilestoneOfProjects13
//
//  Created by begaiym akunova on 1/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        title = "\(selectedImage?.dropLast(4).uppercased() ?? "")"
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            
        }
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func share() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found!")
            return
        }
        
        let text = selectedImage!.dropLast(4)
        
        let vc = UIActivityViewController(activityItems: [text, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    

}
}
