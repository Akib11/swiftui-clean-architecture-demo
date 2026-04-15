//
//  NetworkLogger.swift
//  RandomUserApp
//
//  Created by Akib Quraishi on 14/06/2022.
//

import Foundation


class NetworkLogger {
    
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    //static func log(response: URLResponse) {}
    
    static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
        print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
            output += "\(urlString)"
            output += "\n\n"
        }
        if let statusCode =  response?.statusCode {
            output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "🔵🔴\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }
    
    static func printLog(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        let className = file.components(separatedBy: "/").last
        print(" ❌ Error ----> File: \(className ?? ""), Function: \(function), Line: \(line)")
        print("📡 [Networking Error Caught] \(type(of: error)) – \(error.localizedDescription)\n")
        print("🔍 NSError code: \((error as NSError).code) | domain: \((error as NSError).domain)\n")
    }
    
    /*
    static func printLog(
        _ error: Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let className = file.components(separatedBy: "/").last ?? "UnknownFile"
        
        print("❌ Error ---->")
        print("   • File: \(className)")
        print("   • Function: \(function)")
        print("   • Line: \(line)\n")
        
        print("📡 [Networking Error Caught]")
        print("   • Type: \(type(of: error))")
        print("   • Description: \(error.localizedDescription)\n")
        
        let nsError = error as NSError
        print("🔍 NSError")
        print("   • Code: \(nsError.code)")
        print("   • Domain: \(nsError.domain)\n")
    }
     */
}
