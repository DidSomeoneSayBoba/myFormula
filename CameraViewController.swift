import UIKit
import AVFoundation
import Photos
import Vision
//import GoogleMobileVision
class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
   
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    let deviceOutput = AVCapturePhotoOutput()
    @IBOutlet weak var heightThing: NSLayoutConstraint!
   // var textDetector=GMVDetector(ofType: GMVDetectorTypeText, options: nil)
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var formulaField: UITextField!
    var textRequest: VNRecognizeTextRequest!

    var session = AVCaptureSession()
   // var requests = [VNRequest]()
    override func viewDidLoad() {
        super.viewDidLoad()
        textRequest = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
        textRequest.recognitionLevel = .accurate
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(CameraViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CameraViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height+20)*(show ? -1 : 1)
        //5
        heightThing.constant -= changeInHeight
    }
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    func handleDetectedText(request: VNRequest?, error: Error?) {
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        guard let results = request?.results, let textResults = results as? [VNRecognizedTextObservation] else {
            return
        }
        
        var detectedText = ""
        for textObservation in textResults {
            guard let topCandidate = textObservation.topCandidates(1).first else {
                continue
            }
            detectedText += topCandidate.string
        }
        
        DispatchQueue.main.async {
            self.formulaField.text = self.converttomyformat(detectedText)
        }
    }
    
    func converttomyformat(_ equation:String)->String{
        let array = Array(equation)
        var final = ""
        var afterequation = false
        var firststring = ""
        var laststring = ""
        var charusedbefore = false
        var justchanged = false
        var myformat = false
        for char in array{
            if String(char) == "="{
         justchanged = true
                if firststring.count == 1{
                myformat = true
                }
                afterequation = true
            }
            else {
                if afterequation == false{
                    
                firststring += String(char)
            }
            else{
            laststring += String(char)
            }
        }
        }
        if myformat == false{
        final = equation
        }
        else{
            final = laststring+"="+firststring
            
        }
        return matomta(final)
    }
    @IBAction func confirm(_ sender: Any) {
        let thing = imageView.image
        if thing != nil{
            textdetthing(thing!)
            
            
        }
        let snapshot:UIImage = thing!
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: snapshot)
        }, completionHandler: { success, error in
            if success {
                // Saved successfully!
            }
            else if let error = error {
                // Save photo failed with error
            }
            else {
                // Save photo failed with no error
            }
        })
    }
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as! UIImage
    imageView.image = image
    dismiss(animated: true, completion: nil)
    
    guard let cgImage = image.cgImage else {
        return
    }
    
    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
    do {
        try requestHandler.perform([self.textRequest])
    } catch {
        print("Failed to perform text request: \(error)")
    }
    }
   @IBAction func take(_ sender: Any) {
        print("photo lol")
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera;
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func textdetthing(_ a:UIImage){
      /*  var thingstring = ""
        var features:[GMVTextBlockFeature]=self.textDetector?.features(in: a, options: nil) as! [GMVTextBlockFeature]
        if features != nil{
            for feature in features{
                print(NSStringFromCGRect(feature.bounds))
                print("value is \(feature.value)")
                thingstring += feature.value
            }}
        formulaField.text = convertEquation(thingstring)
        testLabel.text = "Confirm value below"*/
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    override func viewDidLayoutSubviews() {
       // imageView.layer.sublayers?[0].frame = imageView.bounds
    }
 /*   func startTextDetection() {
                let textRequest = VNDetectTextRectanglesRequest(completionHandler: self.detectTextHandler)
        textRequest.reportCharacterBoxes = true
        
        self.requests = [textRequest]
        
    }
    func detectTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results else {
            print("no result")
            return
        }
        
        let result = observations.map({$0 as? VNTextObservation})
        DispatchQueue.main.async() {
            self.imageView.layer.sublayers?.removeSubrange(1...)
            for region in result {
                guard let rg = region else {
                    continue
                }
                
                self.highlightWord(box: rg)
                
                if let boxes = region?.characterBoxes {
                    for characterBox in boxes {
                        self.highlightLetters(box: characterBox)
                        
                       //self.textdetthing()
                    }
                }
            }
        }
    }
    func highlightWord(box: VNTextObservation) {
        guard let boxes = box.characterBoxes else {
            return
        }
        
        var maxX: CGFloat = 9999.0
        var minX: CGFloat = 0.0
        var maxY: CGFloat = 9999.0
        var minY: CGFloat = 0.0
        
        for char in boxes {
            if char.bottomLeft.x < maxX {
                maxX = char.bottomLeft.x
            }
            if char.bottomRight.x > minX {
                minX = char.bottomRight.x
            }
            if char.bottomRight.y < maxY {
                maxY = char.bottomRight.y
            }
            if char.topRight.y > minY {
                minY = char.topRight.y
            }
        }
        
        let xCord = maxX * imageView.frame.size.width
        let yCord = (1 - minY) * imageView.frame.size.height
        let width = (minX - maxX) * imageView.frame.size.width
        let height = (minY - maxY) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 2.0
        outline.borderColor = UIColor.red.cgColor
        
        imageView.layer.addSublayer(outline)
        var features=textDetector?.features(in: imageView.image, options: nil)
        if features != nil{
            for feature in features!{
                print(feature.type)
            }}

    }
    func highlightLetters(box: VNRectangleObservation) {
        let xCord = box.topLeft.x * imageView.frame.size.width
        let yCord = (1 - box.topLeft.y) * imageView.frame.size.height
        let width = (box.topRight.x - box.bottomLeft.x) * imageView.frame.size.width
        let height = (box.topLeft.y - box.bottomLeft.y) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 1.0
        outline.borderColor = UIColor.blue.cgColor
        
        imageView.layer.addSublayer(outline)
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotformula" {
            if let destination = segue.destination as? FormulasViewController {
                if formulaField.text! != ""{
                if formulaField.text!.contains("="){
                    destination.gottem = converttomyformat(self.formulaField.text!)
                }
                else{
                    destination.gottem = converttomyformat(self.formulaField.text!+"=a")
                }
            }
            }
        }
    }
}
/*
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        var requestOptions:[VNImageOption : Any] = [:]
        
        if let camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
            requestOptions = [.cameraIntrinsics:camData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 6)!, options: requestOptions)
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
}

*/
