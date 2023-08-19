import UIKit

class LocationSettingViewModel {
    
    //MARK: - Output
    
    var locations: [LocationSetting] = [LocationSetting(leftTitle: "위치정보 이용동의 (선택)", rightItem: false)]
    
    func getLocation(at index: Int) -> LocationSetting? {
        guard index < locations.count else {
            return nil
        }
        return locations[index]
    }
}
