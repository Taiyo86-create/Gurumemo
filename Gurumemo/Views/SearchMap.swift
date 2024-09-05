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
      VStack {
        Map(coordinateRegion: $manager.region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode
        )
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .edgesIgnoringSafeArea(.bottom)
        
        Spacer()
      }
    }
}
