//
//  SearchMap.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/04.
//

import SwiftUI
import MapKit

struct SearchMap: View {
  @ObservedObject var manager = LocationManager()
  @State var trackingMode = MapUserTrackingMode.follow
  @State private var selectedLocation: Location? = nil
  
  var body: some View {
    VStack {
      Map(coordinateRegion: $manager.region,
          showsUserLocation: true,
          userTrackingMode: $trackingMode,
          annotationItems: [selectedLocation].compactMap { $0 }) { location in
        MapPin(coordinate: location.coordinate, tint: .blue)
      }
          .frame(height: UIScreen.main.bounds.height * 0.6)
          .edgesIgnoringSafeArea(.bottom)
          .gesture(
            DragGesture().onChanged { value in
              let newLocation = Location(
                coordinate: CLLocationCoordinate2D(
                  latitude: manager.region.center.latitude + value.translation.height / 100000,
                  longitude: manager.region.center.longitude + value.translation.width / 100000
                )
              )
              selectedLocation = newLocation
              print("New Location - Latitude: \(newLocation.coordinate.latitude), Longitude: \(newLocation.coordinate.longitude)")
            }
          )
      
      Spacer()
    }
  }
}
