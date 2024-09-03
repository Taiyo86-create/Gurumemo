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
  
  private func checkLocationAuthorization() {
    let status = CLLocationManager.authorizationStatus()
    switch status {
    case .notDetermined:
      // まだユーザーに許可を求めていない状態
      cllLocationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
      // 位置情報の利用が制限されているか、拒否されている状態
      print("Location access restricted or denied.")
    case .authorizedAlways, .authorizedWhenInUse:
      // 常に利用するか、アプリ使用中のみ利用を許可された状態
      print("Location access granted.")
      cllLocationManager.startUpdatingLocation() // 位置情報の更新を開始
    @unknown default:
      // 将来の新しいステータスへの対応
      print("Unknown location status.")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    DispatchQueue.main.async {
      self.region.center = location.coordinate
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to find user's location: \(error.localizedDescription)")
  }
}
