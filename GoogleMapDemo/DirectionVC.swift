//
//  DirectionVC.swift
//  GoogleMapDemo
//
//  Created by Mahendra on 29/05/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

protocol DirectionVCDelegate {
    func routeDidFound(data: GRGoogleRoute?, origin: String?, dest: String?)
}

class DirectionVC: UIViewController, UITextFieldDelegate {

    
    //MARK:- Outlets
    @IBOutlet weak var txtSrc: UITextField!
    @IBOutlet weak var txtDest: UITextField!
    @IBOutlet weak var btnDirection: UIButton!
    
    //MARK:- Properties
    var delegate: DirectionVCDelegate?
    var mode = "Driving"
   
    //-----------------------------------------------------
    
    //MARK:- Memory Management Method
    
    //-----------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //-----------------------------------------------------
    
    //MARK:- Class Method
    
    //-----------------------------------------------------
    
    class func viewController() -> DirectionVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DirectionVC") as! DirectionVC
    }
    
    //-----------------------------------------------------
    
    //MARK:- Action Methods
    
    //-----------------------------------------------------
    
    @IBAction func btnDirectionTapped(_ sender: UIButton) {
        callWSToGetDirection()
    }
    
    //-----------------------------------------------------
    
    //MARK:- Custom Methods
    
    //-----------------------------------------------------
    
    func setupView() {
        
        self.title = ""
        btnDirection.layer.borderWidth = 1
        btnDirection.layer.cornerRadius = 8
        btnDirection.layer.borderColor = UIColor.white.cgColor
        
        let img = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        let btn = UIBarButtonItem(image: img, style: .done, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem = btn
    }
    
    //-----------------------------------------------------
    
    @objc fileprivate func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //-----------------------------------------------------
    
    //MARK:- WS Method
    
    //-----------------------------------------------------
    
    func callWSToGetDirection() {
        
        guard let origin = txtSrc.text, !origin.isEmpty else {
            return
        }
        
        guard let destination = txtDest.text, !destination.isEmpty else {
            return
        }
        
        var url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(mode)"
//        &key=\(kGoogleMap_API_KEY)"

        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        guard let baseUrl = URL(string: url) else {
            print("invalid url")
            return
        }
        
        print(url)
        
        Alamofire.request(baseUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            DispatchQueue.main.async {
                
                if let data = Mapper<GRGoogleRoute>().map(JSONObject: response.result.value) {
                    
                    print(data.dictionaryRepresentation())
                    
                    self.delegate?.routeDidFound(data: data, origin: origin, dest: destination)
                    
                } else {
                    print(response.description)
                    self.delegate?.routeDidFound(data: nil, origin: nil, dest: nil)
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //-----------------------------------------------------
    
    //MARK:- View Life Cycle Methods
    
    //-----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    //-----------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //-----------------------------------------------------
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
   
}

extension DirectionVC: XMLParserDelegate {
    
    
}

