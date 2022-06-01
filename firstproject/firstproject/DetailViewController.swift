//
//  DetailViewController.swift
//  firstproject
//
//  Created by begaiym akunova on 25/3/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var totalPictures = 0
    var numberOfImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(numberOfImage) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recommend", style: .plain, target: self, action: #selector(recommend))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
