//
//  LocationManager.swift
//  Gliding
//
//  Created by 안정흠 on 8/27/24.
//  https://co-dong.tistory.com/73

import CoreLocation

final class LocationManager: NSObject {
    // 위치 정보 권한 획득
    // 위치 정보에 따른 도로명 주소 변환
    // 위치 정보 리프레시
    private var locationManager = CLLocationManager()
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        if checkAuthorizationStatus() { locationManager.startUpdatingLocation() }
    }
    
    func checkAuthorizationStatus() -> Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied: // 사용자가 권한 삭제한 경우
            return false
        case .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization()
            return checkAuthorizationStatus()
        @unknown default:
            return false
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
}
