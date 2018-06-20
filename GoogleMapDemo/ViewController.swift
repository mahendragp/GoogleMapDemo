//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Neal on 28/05/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var view_mapContainer: GMSMapView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnTransit: UIBarButtonItem!
    @IBOutlet weak var lblDetails: UILabel!
    
    var foundCurrLoc = false
    let locMan = CLLocationManager()
    var mode = "Driving" {
        didSet {
            self.btnTransit.image = UIImage(named: mode.lowercased())
        }
    }
    
    var origin: String?
    var destination: String?
    
    //-----------------------------------------------------
    
    //MARK:- Memory Management
    
    //-----------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-----------------------------------------------------
    
    //MARK:- Action Methods
    
    //-----------------------------------------------------
    
    @IBAction func btnMapTypeTapped(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: .actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: .default) { (alertAction) -> Void in
            DispatchQueue.main.async {
                self.view_mapContainer!.mapType = .normal
            }
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: .default) { (alertAction) -> Void in
            DispatchQueue.main.async {
                self.view_mapContainer!.mapType = .terrain
            }
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: .default) { (alertAction) -> Void in
            DispatchQueue.main.async {
                self.view_mapContainer!.mapType = .hybrid
            }
        }
        
        let satelliteMapTypeAction = UIAlertAction(title: "Satellite", style: .default) { (alertAction) -> Void in
            DispatchQueue.main.async {
                self.view_mapContainer!.mapType = .satellite
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: .cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(satelliteMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    //-----------------------------------------------------
    
    @IBAction func btnModeTapped(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Mode", message: "Select mode of travel", preferredStyle: .actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Driving", style: .default) { (alertAction) -> Void in
            self.mode = alertAction.title!
            self.recreatePath()
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Walking", style: .default) { (alertAction) -> Void in
            self.mode = alertAction.title!
            self.recreatePath()
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Bicycling", style: .default) { (alertAction) -> Void in
            self.mode = alertAction.title!
            self.recreatePath()
        }
        
        let satelliteMapTypeAction = UIAlertAction(title: "Transit", style: .default) { (alertAction) -> Void in
            self.mode = alertAction.title!
            self.recreatePath()
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: .cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(satelliteMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    //-----------------------------------------------------
    
    @IBAction func btnDirectionTapped(_ sender: UIBarButtonItem) {
        let vc = DirectionVC.viewController()
        vc.delegate = self
        vc.mode = mode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //-----------------------------------------------------
    
    @IBAction func btnLocationTapped(_ sender: UIBarButtonItem) {
        
        let vc = UIAlertController(title: "Demo", message: "Enter place name to search", preferredStyle: .alert)
        vc.addTextField { (textField) in
            textField.placeholder = "Place name"
        }
        
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if let textField = vc.textFields?.first {
                
                self.searchPlace(txt: textField.text!)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        vc.addAction(actionCancel)
        vc.addAction(actionOK)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //-----------------------------------------------------
    
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        
    }
    
    //-----------------------------------------------------
    
    //MARK:- Custom Methods
    
    //-----------------------------------------------------

    func searchPlace(txt: String) {
        
        view_mapContainer.clear()
        
        let mng = CLGeocoder()
        mng.geocodeAddressString(txt) { (placemarks, error) in
            
            DispatchQueue.main.async {
                
                guard let places = placemarks, let location = places.first?.location else {
                    
                    return
                }
                
                self.view_mapContainer.camera = GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0)
                
                let marker = GMSMarker()
                marker.icon = UIImage(named: "Image")
//                marker.icon
                marker.appearAnimation = GMSMarkerAnimation(rawValue: 1)!
                marker.position = location.coordinate
                marker.title = txt
                marker.snippet = txt
                marker.map = self.view_mapContainer
                
            }
        }
    
    }
    
    //-----------------------------------------------------
    
    func recreatePath() {
        
        guard let origin = self.origin, !origin.isEmpty else {
            return
        }
        
        guard let destination = self.destination, !destination.isEmpty else {
            return
        }
        
        var url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(mode)"
        
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
                    
                    self.routeDidFound(data: data, origin: origin, dest: destination)
                    
                } else {
                    print(response.description)
                    self.routeDidFound(data: nil, origin: nil, dest: nil)
                }
            }
        }
    }
    
    //-----------------------------------------------------
    
    //MARK:- View life cycle
    
    //-----------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locMan.requestAlwaysAuthorization()
        locMan.startUpdatingLocation()
        
        view_mapContainer.isMyLocationEnabled = true
        view_mapContainer.settings.myLocationButton = true
    }
    
    //-----------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //-----------------------------------------------------
    
}

//-----------------------------------------------------

//MARK:- CLLocationManagerDelegate

//-----------------------------------------------------

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locMan.startUpdatingLocation()
        
        view_mapContainer.isMyLocationEnabled = true
        view_mapContainer.settings.myLocationButton = true
    }
    
    //-----------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        view_mapContainer.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locMan.stopUpdatingLocation()
        print("Updating location \(location.coordinate)")
    }
}

//-----------------------------------------------------

//MARK:- DirectionVCDelegate

//-----------------------------------------------------

extension ViewController: DirectionVCDelegate {

    func routeDidFound(data: GRGoogleRoute?, origin: String?, dest: String?) {
        
        guard let data = data else {
            print("Route not found !!")
            return
        }
        
        self.origin = origin ?? nil
        self.destination = dest ?? nil
        
        if let routes = data.routes, !routes.isEmpty {
            
            self.view_mapContainer.clear()
            
            if let legs = data.routes?.first?.legs?.first {
            
                var lat = legs.startLocation?.lat ?? 0
                var lng = legs.startLocation?.lng ?? 0
                
                let srcMarker = GMSMarker(position: CLLocationCoordinate2DMake(Double(lat), Double(lng)))
                let startAddress = data.routes?.first?.legs?.first?.startAddress ?? ""
                srcMarker.title = startAddress
                srcMarker.snippet = "\(lat, lat)"
                srcMarker.map = view_mapContainer
                srcMarker.appearAnimation = .pop
            
                lat = legs.endLocation?.lat ?? 0
                lng = legs.endLocation?.lng ?? 0
                
                let destMarker = GMSMarker(position: CLLocationCoordinate2DMake(Double(lat), Double(lng)))
                
                let endAddress = data.routes?.first?.legs?.first?.endAddress ?? ""
                destMarker.title = endAddress
                destMarker.snippet = "\(lat, lat)"
                destMarker.map = view_mapContainer
                destMarker.appearAnimation = .pop
                
                lblDetails.text = ""
                if let dur = legs.duration?.text {
                    lblDetails.text! += "Distance: \(dur)\n"
                }
                
                if let dis = legs.distance?.text {
                    lblDetails.text! += "Duration: \(dis)"
                }
                
            }
            
            for route in routes {
                if let points = route.overviewPolyline?.points {
                    
                    let path = GMSPath(fromEncodedPath: points)
                    
                    let polyline = GMSPolyline(path: path)
                    polyline.strokeWidth = 3
                    polyline.strokeColor = UIColor.cyan
                    polyline.geodesic = true
                    
                    let bounds = GMSCoordinateBounds(path: path!)
                    self.view_mapContainer.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30))
                    polyline.map = self.view_mapContainer
                }
            }
        }
    }
}

