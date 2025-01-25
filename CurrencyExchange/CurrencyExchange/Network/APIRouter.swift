//
//  APIRouter.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case rates
}

extension APIRouter {
    private var method: HTTPMethod {
        switch self {
        case .rates: .get
        }
    }
    
    private var path: String {
        switch self {
        case .rates: "rates"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .rates: nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest: URLRequest
        let baseURLStr: NSString = APIConstants.baseURL as NSString
        let fullURLStr = baseURLStr.appendingPathComponent(path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = try fullURLStr.asURL()
        
        urlRequest = try URLRequest(url: url, method: method)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.textPlain.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        urlRequest.setValue("ApiKey ", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncoderFailed(reason: .encoderFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
