//
//  CreatePost.swift
//  EASY
//
//  Created by Rohit Saini on 01/10/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class CreatePost: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var profilePic: UIImageView!
    var isImagePost: Bool = true
    var categoryID: String = ""
    var categoryName: String = ""
    var videoUrl: URL!
    var PostImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()

        // Do any additional setup after loading the view.
    }
    
    private func customization(){
        profilePic.downloadCachedImage(placeholder: "user_avatar", urlString: AppModel.shared.loggedInUser.profilePicLink)
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
        profilePic.layer.borderWidth = 1
        profilePic.layer.borderColor = UIColor.white.cgColor
        
    }
    
    
    
    @IBAction func clickPostBtn(_ sender: UIButton) {
        if categoryBtn.currentTitle == "Select Category"{
            displayToast("Please select post category")
        }
        else{
            if isImagePost{
                User.CreatePost(userId: AppModel.shared.loggedInUser.id, username: AppModel.shared.loggedInUser.name, categoryId: categoryID, categoryName: categoryName, postText: postTextView.text, mediaType: POSTMEDIA.IMAGE, postMediaData: compressImage(image: PostImage ?? UIImage()), videoUrl: nil) { (loginHandler) in
                    if loginHandler == nil{
                        displayToast("\(self.categoryName) Post created successfully")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        displayToast(loginHandler ?? "")
                    }
                }
            }
            else{
                User.CreatePost(userId: AppModel.shared.loggedInUser.id, username: AppModel.shared.loggedInUser.name, categoryId: categoryID, categoryName: categoryName, postText: postTextView.text, mediaType: POSTMEDIA.VIDEO, postMediaData: Data(), videoUrl: videoUrl) { (loginHandler) in
                    if loginHandler == nil{
                        displayToast("\(self.categoryName) Post created successfully")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        displayToast(loginHandler ?? "")
                    }
                }
            }
            
        }
    }
    
    @IBAction func clickCrossBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func clickAddBtn(_ sender: UIButton) {
        PostMedia()
    }
    
    @IBAction func clickCategoryBtn(_ sender: UIButton) {
        RPicker.selectOption(dataArray: GROUPS_CATEGORIES.GROUP_PHOTOS_PLUS_NAME) { [unowned self](category, index) in
            self.categoryID = "\(index)"
            self.categoryName = category
            self.categoryBtn.setTitle(category, for: UIControl.State.normal)
        }
    }
    
    private func addPostContent(postImage: UIImage){
        var attributedString :NSMutableAttributedString!
        attributedString = NSMutableAttributedString(attributedString:postTextView.attributedText)
        let textAttachment = NSTextAttachment()
        textAttachment.image = postImage

        let oldWidth = textAttachment.image!.size.width;

        //I'm subtracting 10px to make the image display nicely, accounting
        //for the padding inside the textView

        let scaleFactor = oldWidth / (postTextView.frame.size.width - 10);
        textAttachment.image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.append(attrStringWithImage)
        postTextView.attributedText = attributedString;
    }
    
    
     // MARK: - Upload Image
        @objc func PostMedia()
        {
            let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheet.addAction(cancelButton)
            
            let cameraButton = UIAlertAction(title: "Camera", style: .default)
            { _ in
                print("Camera")
                self.onCaptureImageThroughCamera()
            }
            
            
            actionSheet.addAction(cameraButton)
            
            
            
            let galleryButton = UIAlertAction(title: "Gallery", style: .default)
            { _ in
                print("Gallery")
                self.onCaptureImageThroughGallery()
            }
            actionSheet.addAction(galleryButton)
            
            
            actionSheet.popoverPresentationController?.sourceView = self.view
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            actionSheet.popoverPresentationController?.permittedArrowDirections = []
            actionSheet.view.tintColor = colorFromHex(hex: "#101B39")
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        @objc open func onCaptureImageThroughCamera()
        {
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                //displayToast("Your device has no camera")
                
            }
            else {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .camera
                imgPicker.mediaTypes = [kUTTypeMovie,kUTTypeImage] as [String]

              
                self.present(imgPicker, animated: true, completion: nil)
                
            }
        }
        
        @objc open func onCaptureImageThroughGallery()
        {
//
            DispatchQueue.main.async {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .photoLibrary
                imgPicker.mediaTypes = [kUTTypeMovie,kUTTypeImage] as [String]
               
            
                self.present(imgPicker, animated: true, completion: nil)
                
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //Video Picking Process
            if let videoUrl = (info[UIImagePickerController.InfoKey.mediaURL]) as? NSURL{
                
            if let thumbnailImage = thumbnailImageForFileUrl(fileUrl: videoUrl as URL){
                       picker.dismiss(animated: true, completion: {()  -> Void  in
                        self.isImagePost = false
                        self.videoUrl = videoUrl as URL
                        self.addPostContent(postImage: thumbnailImage)
                })
                  
            }
                    
                    
        }
               
            else{
              handleImageSelectedForInfo(info: info,picker: picker)
            }
            
        }
        
        
        private func thumbnailImageForFileUrl(fileUrl: URL) -> UIImage?{
            let asset = AVAsset(url: fileUrl)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            do{
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
                return UIImage(cgImage: thumbnailCGImage)
            }
            catch let err{
                print(err)
            }
            return nil
            
        }
       
        
       
        //MARK:- Selected Image
        private func handleImageSelectedForInfo(info: [UIImagePickerController.InfoKey: Any],picker: UIImagePickerController){
            //Image Picking Process
            var selectedImage: UIImage?
            if let editedImage = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage){
                selectedImage = editedImage
            }
            else if let originalImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage){
                selectedImage = originalImage
            }
            
            if let finalImage = selectedImage{
                picker.dismiss(animated: true, completion: {() -> Void in
                    self.isImagePost = true
                    self.PostImage = finalImage
                    self.addPostContent(postImage: finalImage)
                })
            }
        }
        
    
    deinit{
       print("Create Post Controller Deinit from memory")
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
