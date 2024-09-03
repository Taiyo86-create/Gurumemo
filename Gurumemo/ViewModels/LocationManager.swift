//
//  LocationManager.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  private var cllLocationManager = CLLocationManager()
  
  @Published var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  
  override init() {
    super.init()
    cllLocationManager.delegate = self
    cllLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    cllLocationManager.requestWhenInUseAuthorization()
  }
  
}
