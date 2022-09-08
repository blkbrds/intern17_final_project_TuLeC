//
//  MyPin.swift
//  FinalProject
//
//  Created by tu.le2 on 07/09/2022.
//

import Foundation
import MapKit

final class MyPin: NSObject, MKAnnotation {
    private(set) var title: String?
    private(set) var coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
