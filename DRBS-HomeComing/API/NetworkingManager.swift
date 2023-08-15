import UIKit


class NetworkingManager {
    //MARK: - Singleton Pattern
    static let shared = NetworkingManager()
    private init() {}
    
    //MARK: - 체크리스트관련메서드

    
    
    
    //MARK: - 지도관련메서드

    func fetchAnnotations(completion: @escaping([Location]) -> Void) {
        //파이어 베이스에서 location 배열을 받아와서 completion을 통해 얻는다.
        
        
    }
    func fetchAreaName(completion: @escaping([String]) -> Void) {
        //파이어 베이스에서 전국 지역명 배열을 받아와서 completion을 통해 얻는다.
        
        
    }
    
    
}
