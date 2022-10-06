//
//  AppVersion.swift
//  Pods
//
//  Created by serkan doksöz on 2.10.2022.
//

import Foundation

public struct AppVersionResponse: Codable {
    let status: Bool?
    let message: String?
    let ios: Int?
    
    public init(status: Bool?, message: String?, ios: Int?) {
        self.message = message
        self.status = status
        self.ios = ios
    }
}


public protocol AppVersionApiProtocol{
    func AppVersionOnSuccess(response: AppVersionResponse?)
    func AppVersionOnError(msg : String, type : Int)
}

public class AppVersionApi{
    
    public init() {
        
    }
    
    public var delegate : AppVersionApiProtocol?
    
    public func AppVersion(){
        
        //print("AppVersionRequestModel - \(AppVersionRequestModel)")
        
        let url = URL(string: "https://posservice.esnekpos.com/mpos/GetAppVersionNumber")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let json = JSONSerializer.toJson(AppVersionRequestModel)
        //request.httpBody = json.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }
            
            //guard let data = data else {return}
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("No valid response")
                return
            }
            
            do{
                let AppVersionResponse = try JSONDecoder().decode(AppVersionResponse.self, from: data)
                self.delegate?.AppVersionOnSuccess(response: AppVersionResponse)
                return
                
            } catch let err {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print(err)
                }
            }
            self.delegate?.AppVersionOnError(msg: "NetworkHTTPStatusError", type: httpResponse.statusCode)
            
        }
        task.resume()
    }
}
