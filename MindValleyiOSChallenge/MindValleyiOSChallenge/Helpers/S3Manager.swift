//
//  S3Manager.swift
//  QulabroProject
//
//  Created by Asad Khan on 11/17/18.
//  Copyright © 2018 Mobitribe. All rights reserved.
//

import Foundation
//import AWSS3
//import AWSCore
//import PromiseKit

class S3Manager{
    
    static let shared = S3Manager()
    //    bucketName: '',
    //    accessKeyId: ,
    //    secretAccessKey: ,
    //    region: 'us-east-2'
    
    let accessKey = "AKIAJXJKPR6JBCN2G2PQ"
    let secretKey = "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"
    
    func upload(image:UIImage)->Promise<String> {
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.EUWest2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let S3BucketName = "visconn-dev"
        let remoteName = "CompanyProfile.jpg"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(remoteName)
        //let image = UIImage(named: "test")
        
        
        let data = UIImageJPEGRepresentation(image, 0.9)
        do {
            try data?.write(to: fileURL)
        }
        catch {}
        
        let uploadRequest           = AWSS3TransferManagerUploadRequest()!
        uploadRequest.body          = fileURL
        uploadRequest.key           = remoteName
        uploadRequest.bucket        = S3BucketName
        uploadRequest.contentType   = "image/jpeg"
        uploadRequest.acl           = .publicRead
        
        
//        uploadRequest.uploadProgress = { (bytesSent, totalBytesSent, totalBytesExpectedToSend) -> Void in
//
//                print("\(totalBytesSent)/\(totalBytesExpectedToSend)")
//
//        }
        
        let transferManager = AWSS3TransferManager.default()
        return Promise<String> { seal in
            transferManager.upload(uploadRequest).continueWith {  (task) -> Any? in
               
                
                if let error = task.error {
                    print("Upload failed with error: (\(error.localizedDescription))")
                    
                    seal.reject(error)
                }
                
                if task.result != nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
                    if let absoluteString = publicURL?.absoluteString {
                        print("Uploaded to:\(absoluteString)")
                       
                            seal.fulfill(absoluteString)
                        
                        
                    }
                }
                
                return nil
            }
            
        }
        
    }
    
    
}
