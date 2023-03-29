//
//  ViewController.swift
//  Map
//
//  Created by Владимир on 21.02.2023.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class ViewController: UIViewController  {
    
    //MARK: - Outlets
    
    @IBOutlet weak var map: MKMapView!
    let addAdressBut: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить адрес", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    //MARK: - UI Elements
    
    let resetBut: UIButton = {
        let button = UIButton()
        button.setTitle("Сбросить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true
        return button
    }()
    let searchBut: UIButton = {
        let button = UIButton()
        button.setTitle("Построить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true
        return button
    }()
    
    var annotaionArray: [MKPointAnnotation] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        setViews()
        
        
        addAdressBut.addTarget(self, action: #selector(addAdress), for: .touchUpInside)
        resetBut.addTarget(self, action: #selector(reset), for: .touchUpInside)
        searchBut.addTarget(self, action: #selector(search), for: .touchUpInside)
        
    }
    
    //MARK: - Private methods
    
    private func setPlaceMarks(address:String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {[self] placemarks, error in
            if error != nil {
                self.addErrorAlert()
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = address
            guard let placemarkLoc = placemark?.location else { return }
            annotation.coordinate = placemarkLoc.coordinate
            annotaionArray.append(annotation)
            
            if annotaionArray.count>1 {
                resetBut.isHidden = false
                searchBut.isHidden = false
            }
            map.showAnnotations(annotaionArray, animated: true)
        }
    }
    
    private func setDir(start:CLLocationCoordinate2D, finish:CLLocationCoordinate2D) {
        let startLoc = MKPlacemark(coordinate: start)
        let finishLoc = MKPlacemark(coordinate: finish)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLoc)
        request.destination = MKMapItem(placemark: finishLoc)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let direction = MKDirections(request: request)
        direction.calculate { responce, error in
            if error != nil {
                return
            }
            guard let responce = responce else {
                self.addErrorAlert()
                return
            }
            
            var minRoute = responce.routes[0]
            for i in responce.routes {
                if i.distance < minRoute.distance {
                    minRoute = i
                }
                self.map.addOverlay(minRoute.polyline)
            }
        }
    }
    
    //MARK: - Button actions
    
    @objc func addAdress() {
        addAlert { text in
            self.setPlaceMarks(address: text)
        }
    }
    
    @objc func reset() {
        map.removeAnnotations(annotaionArray)
        annotaionArray.removeAll()
        searchBut.isHidden = true
        resetBut.isHidden = true
    }
    
    @objc func search() {
        for i in 0...annotaionArray.count - 2 {
            setDir(start: annotaionArray[i].coordinate, finish: annotaionArray[i + 1].coordinate)
        }
        map.showAnnotations(annotaionArray, animated: true)
    }
}

