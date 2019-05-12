//
//  Models.swift
//  IPI
//
//  Created by Felipe Zamudio on 29/04/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import Foundation
import ObjectMapper

/* State: pending */
//class ContactModel: Mappable {
//    var fullName: String!
//    var number: String!
//
//    init() {}
//
//    required init?(map: Map) {}
//
//    func mapping(map: Map) {
//        fullName <- map[JSONKeys.full_name]
//        number <- map[JSONKeys.number]
//    }
//}
//
///* State: pending */
//class ContactListModel: Mappable {
//
//    var contacList: Array<ContactModel>!
//
//    init() {}
//
//    required init?(map: Map) {}
//
//    func mapping(map: Map) {
//        contacList <- map[JSONKeys.contact_emergency_List]
//    }
//}

/* State: pending */
class CourseListModel: Mappable {

    var courseList: Array<Course>!

    init(courseList: Array<Course>!) {
        self.courseList = courseList
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        courseList <- map[JSONKeys.course_list]
    }
}

// Modelo con los datos basicos para guardar una actividad completada
/* State: pending */
class ActityCompleted {
    var courseID: Int!
    var topicID: Int!
    var activity: String!
    var dateCompleted: String!
}

// State: succed -- UserActivityProgress in android
class RequestCompleted: Mappable {
    var user: Int!
    var topic_activity: Int!
    var date_completed: String!

    init(user: Int, activity: Int, date: String) {
        self.user = user
        self.topic_activity = activity
        self.date_completed = date
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        user <- map[JSONKeys.user]
        topic_activity <- map[JSONKeys.topic_activity]
        date_completed <- map[JSONKeys.date_completed]
    }
}

/* State: pending */
class RequestAvatar: Mappable {
    var user: Int!
    var piece: Int!

    init(pieceID: Int) {
        self.user = AplicationRuntime.sharedManager.getUser().id
        self.piece = pieceID
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        user <- map[JSONKeys.user]
        piece <- map[JSONKeys.avatar_piece]
    }
}

/** Modelo para definir el avatar */
class MyAvatarPieces {

    var headID: Int!
    var eyesID: Int!
    var noseID: Int!
    var hairID: Int!
    var accID: Int!
    var genderID: Int!

    init() {
    }
}

/* State: pending */
//class UserModel {
//    var email: String!
//    var username: String!
//    var token: String!
//    var id: Int!
//}

/// Model used for send request by socialnetwork
class SocialNetworkRegister : Mappable {
    var email: String!
    var access_token: String!
    
    //inicializador vacio
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        email <- map[JSONKeys.email]
        access_token <- map[JSONKeys.access_token]
    }
}

/// Model Used for keep the Authentication states
class StatesModel {
    var hasViewedOnboarding: Bool!
    var isLogin: Bool!
    var isThereAnAvatar: Bool!

    init() {
        self.isLogin = false
        self.isThereAnAvatar = false
        self.hasViewedOnboarding = false
    }
}

/* State: pending */
class FormatsBankItem {

    var name: String!
    var file: String!
    var ext: String!

    init(name: String, file: String, ext: String) {
        self.file = file
        self.name = name
        self.ext = ext
    }
}

/* State: pending */
class MyCommunityItem {

    var title: String!
    var objective: String!
    var note: String!
    var downloadCopy: String!
    var file: String!
    var ext: String!

    init(title: String, objective: String, note: String, downloadCopy: String, file: String, ext: String) {
        self.title = title
        self.objective = objective
        self.note = note
        self.downloadCopy = downloadCopy
        self.file = file
        self.ext = ext
    }
}

/* State: pending */
class ModuleProgressItem {
    var image: String!
    var title: String!
    var progress: Float!

    init(image: String, title: String, progress: Float) {
        self.image = image
        self.title = title
        self.progress = progress
    }
}

/** Modelo para mantener el indice de la pág actual de los cursos */
/* State: pending */
class CoursesProgress {

    var VBG_INDEX: Int! // Indice de pág para el curso Violencia Basada en Genero
    var PLC_INDEX: Int! // Indice de pág para el curso Protección Lideres Comunitarios

    init() {
        self.VBG_INDEX = 0
        self.PLC_INDEX = 0
    }
}
