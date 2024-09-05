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
    var body: some View {
      Map(coordinateRegion: $manager.region,
          showsUserLocation: true,
          userTrackingMode: $trackingMode
      )
      .edgesIgnoringSafeArea(.bottom)
    }
}
