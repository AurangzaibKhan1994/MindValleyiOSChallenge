//
//  APIClient.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

//import Alamofire
//import PromiseKit

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise { seal in
            Alamofire.request(route)
                .validate()
                .responseJSONDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
                    let tempData = response.data
                    print(response.response?.statusCode)
                    
                    switch response.result {
                    case .success(let value):
                        seal.fulfill(value)
                        
                    case .failure(let error):
                        
                        if tempData != nil{
                            do {
                                let errorJSON = try JSONSerialization.jsonObject(with: tempData!, options: [.allowFragments]) as! [String:Any]
                                if let messageArray = errorJSON["msg"] as? [String]{
                                    seal.reject(NetworkError.serverError(messageArray.first!))
                                }else if let message = errorJSON["msg"] as? String{
                                    seal.reject(NetworkError.serverError(message))
                                }else{
                                    seal.reject(NetworkError.serverError((response.error?.localizedDescription)!))
                                }
                                print(errorJSON)
                            } catch {
                                seal.reject(error)
                            }
                        }
                        // Token has expired
                        // send user to login screen
                        if let aferror = error as? AFError{
                            if aferror.responseCode == 401{
                                RootNavigator.shared.setLoginRootVC()
                            }
                        }
                        seal.reject(error)
                    }
                })
        }
    }
    //---------------------------------------------//
    static func login(email: String, password: String, device_type:String)->Promise<Verification> {
        let req = LoginRouter.login(email: email, password: password, device_type:AppConstant.deviceType)
        return performRequest(route:req)
    }
    
    static func setFCM(token:String)-> Promise<SuccessResponse>{
        
        let req = LoginRouter.setFCM(token: token)
        return performRequest(route:req)
    }
    
    static func logout()->Promise<GenericResponse> {
        let req = LoginRouter.logout
        return performRequest(route:req)
    }
    
    static func updateUserAvaialabilityStatus(statusID: Int)->Promise<GenericResponse> {
        let req = LoginRouter.updateStatus(statusID: statusID)
        return performRequest(route:req)
    }
    
    static func register(email:String)-> Promise<Registration>{
        
        let req = RegisterRouter.signup(email: email)
        return performRequest(route:req)
    }
    
    static func verify(code:String, userID:Int)-> Promise<VerifyCode>{
        
        let req = RegisterRouter.verify(code: code, userID: userID)
        return performRequest(route:req)
    }
    
    //    static func postUser(firstName:String, lastName:String)-> Promise<User>{
    //
    //        let req = RegisterRouter.name(first: firstName, last: lastName)
    //
    //        return performRequest(route:req)
    //    }
    
    static func set(password:String)-> Promise<User>{
        
        let req = RegisterRouter.setPassword(password: password)
        return performRequest(route:req)
    }
    
    static func reset(passwordData:[String:String])->Promise<SuccessResponse>{
        
        let req = RegisterRouter.resetPassword(params:passwordData )
        return performRequest(route: req)
    }
    
    static func create(companyName:String,companyNumber:String)-> Promise<Company>{
        
        let req = RegisterRouter.createCompany(name: companyName, contactNumber: companyNumber)
        return performRequest(route:req)
    }
    
    static func updateCompany(profile:[String:String], id:Int)->Promise<Company>{
        
        let req = ProfileRouter.updateCompanyProfile(id: id, data: profile)
        return performRequest(route:req)
    }
    
    static func create(workspaceName:String,for companyID:Int)-> Promise<WorkSpace>{
        
        let req = RegisterRouter.createWorkspace(companyID: companyID, workspaceName: workspaceName)
        return performRequest(route:req)
    }
    
    static func sendInvites(to emails: [String]) -> Promise<ContactInvite>{
        
        let req = RegisterRouter.sentInvite(emails: emails)
        return performRequest(route:req)
    }
    
    static func getCompanyMembers()-> Promise<CompanyMember>{
        
        let req = ProfileRouter.getContacts
        return performRequest(route:req)
    }
    
    static func getConferenceNode()-> Promise<ConferenceNode>{
        
        let req = CallRouter.getConferenceNode
        return performRequest(route:req)
    }
    
    // update user active/inactive status
    static func update(user:Int,status:Bool)-> Promise<SuccessResponse>{
        
        let req = CallRouter.userStatus(id: user, status: status)
        return performRequest(route:req)
    }
    
    static func getUserProfile(id: Int)-> Promise<Profile>{
        
        let req = ProfileRouter.getProfile(id: id) // .getProfile
        return performRequest(route:req)
    }
    
    static func update(user:Int,profile:[String:String])->Promise<Profile>{
        
        let req =  ProfileRouter.updateProfile(id:user , profileData: profile)
        return performRequest(route:req)
    }
    
    static func getMeetings()-> Promise<MeetingList>{
        
        let req = MeetingRouter.meetings
        return performRequest(route:req)
    }
    
    static func getGroupMeetings(id: Int)-> Promise<GroupMeetings>{
        
        let req = GroupRouter.groupMeetings(id: id)
        return performRequest(route:req)
    }
    
    static func getRoomMeetings(id: Int)-> Promise<RoomMeetingsData>{ // RoomMeetings
        
        let req = RoomRouter.roomMeetingList(id: id)
        return performRequest(route:req)
    }
    
    static func getMeetingDetails(id: Int)-> Promise<MeetingDetail>{
        
        let req = MeetingRouter.meetingDetail(meetingID: id)
        return performRequest(route:req)
    }
    
    static func create(Meeting:MeetingData)-> Promise<MeetingDetail>{ // MeetingCreated
        
        let data = APIClient.encode(object: Meeting)
        let req = MeetingRouter.schedule(params: data)
        return performRequest(route:req)
    }
    
    static func update(Meeting:MeetingData, meetingID:Int)-> Promise<MeetingDetail>{ // MeetingCreated
        
        let data = APIClient.encode(object: Meeting)
        let req = MeetingRouter.update(meetingID:"\(meetingID)" , params: data)
        return performRequest(route:req)
    }
    
    static func cancel(Meeting: MeetingDetail)-> Promise<SuccessResponse>{
        
        let req = MeetingRouter.cancel(meetingID: "\(Meeting.data.id)")
        return performRequest(route:req)
    }
    
    static func deleteGroup(id: Int)-> Promise<SuccessResponse>{
        
        let req = GroupRouter.deleteGroup(id: id)
        return performRequest(route:req)
    }
    
    static func deleteRoom(id: Int)-> Promise<SuccessResponse>{
        
        let req = RoomRouter.deleteRoom(id: id)
        return performRequest(route:req)
    }
    
    static func getGroups()->Promise<GroupData>{
        
        let req = GroupRouter.groups
        return performRequest(route:req)
    }
    
    static func create(group:CreateGroup)-> Promise<CreatedGroup>{
        
        let data = APIClient.encode(object: group)
        let req = GroupRouter.create(group: data)
        return performRequest(route:req)
    }
    
    static func update(groupID:Int,group:CreateGroup)-> Promise<CreatedGroup>{
        
        let data = APIClient.encode(object: group)
        let req = GroupRouter.update(id:groupID , group: data)
        return performRequest(route:req)
    }
    
    static func groupDetail(id:Int)-> Promise<CreatedGroup>{
        
        let req = GroupRouter.detail(id: id)
        return performRequest(route:req)
    }
    
    static func groupUserMeeting(id:Int)-> Promise<GroupMeetingsData>{
        
        let req = GroupRouter.groupMeetings(id: id)
        return performRequest(route:req)
    }
    
    static func getRooms()->Promise<RoomList>{
        
        let req = RoomRouter.rooms
        return performRequest(route:req)
    }
    
    static func create(room:CreateRoom)-> Promise<SuccessResponse>{
        
        let data = APIClient.encode(object: room)
        let req = RoomRouter.create(room: data)
        return performRequest(route:req)
    }
    
    static func update(roomID:Int,room:CreateRoom)-> Promise<UpdatedRoom>{
        
        let data = APIClient.encode(object: room)
        let req = RoomRouter.update(id:roomID , room: data)
        return performRequest(route:req)
    }
    
    static func roomDetail(id:Int)-> Promise<RoomDetailData>{
        
        let req = RoomRouter.detail(id: id)
        print("Room Detail = \(req)")
        return performRequest(route:req)
    }
    
    static func delete(roomID:Int)->Promise<RoomDeleted>{
        
        let req = RoomRouter.deleteRoom(id: roomID)
        return performRequest(route: req)
    }
    
    static func roomMeetingList(id:Int)-> Promise<RoomMeetings>{
        
        let req = RoomRouter.roomMeetingList(id: id)
        print("Room Meeting List = \(req)")
        return performRequest(route:req)
    }
    
    // fetch list of all devices
    static func devices()-> Promise<DeviceList>{
        
        let req = DeviceRouter.getDevices
        return performRequest(route:req)
    }
    
    static func deviceDetail(deviceID:Int)-> Promise<DeviceDetail>{
        
        let req = DeviceRouter.detail(id: deviceID)
        return performRequest(route: req)
    }
    
    static func sendChatPush(notification:FCMChatNotification)->Promise<SuccessResponse>{
        
        let req = ChatRouter.sendPushNotification(params: notification)
        return performRequest(route: req)
    }
    
    static func encode<T:Codable>(object:T)->Data{
        
        let encoder = JSONEncoder()
        let data =  try! encoder.encode(object)
        return data
    }
}


