//
//  AplicationRuntime.swift
//  IPI
//
//  Created by Felipe Zamudio on 1/05/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import Foundation
import UIKit

class AplicationRuntime {

    // MARK: - Private properties
    private var appConfig: ApplicationConfiguration!
    private var userData: RegisterUserResponse!
    private var progress: CoursesProgress!
    private var avatar: MyAvatarPieces!

    var avatarImage: UIImage!
    weak var mainDelegate: MainProtocol?
    weak var courseDelegate: CourseViewControllerDelegate?

    // MARK: - Singleton instance
    class var sharedManager: AplicationRuntime {
        struct Static {
            static let instance = AplicationRuntime()
        }
        return Static.instance
    }

    // MARK: - Setters
    public func setAppConfig(config: ApplicationConfiguration!){
        self.appConfig = config
    }

    public func setUserData(user: RegisterUserResponse!) {
        self.userData = user
    }

    public func setAvatarPieces(avatarPieces: MyAvatarPieces) {
        self.avatar = avatarPieces
    }

    public func setAvatarGenderID(id: Int) {
        self.avatar.genderID = id
    }

    public func setAvatarImage(img: UIImage) {
        self.avatarImage = img
    }

    public func setProgress(progress: CoursesProgress) {
        self.progress = progress
    }

    /// Guarda el indice del curso
    public func setProgress(progress: Int) {
        if self.progress == nil { self.progress = CoursesProgress() }
        self.progress.COURSE_INDEX = progress

        StorageFunctions.saveProgress(progress: self.progress)
    }

    // MARK: - GETTERS
    public func getAppConfig() -> ApplicationConfiguration! {
        return self.appConfig
    }

    // MARK: - getters for - Spinners

    // Get for contact us from. Type of Request Spinner
    public func getContactFormTypeList() -> Array<ContactFormType> {
        guard appConfig != nil, appConfig.contact_form_type_Array != nil else {
            return []
        }
        return appConfig.contact_form_type_Array
    }

//    public func getStateList() -> Array<State> {
//        guard appConfig != nil, appConfig.state_Array != nil else {
//            return []
//        }
//        return appConfig.state_Array
//    }

    // MARK: - Getters for validations
    public func getPswRegex() -> String {
        guard appConfig != nil, appConfig.general_configuration.psw_regular_expression != nil else {
            return nullString
        }
        return appConfig.general_configuration.psw_regular_expression
    }

    public func getPswErrorMessage() -> String {
        guard appConfig != nil, appConfig.general_configuration.psw_error_recomendation != nil else {
            return nullString
        }
        return appConfig.general_configuration.psw_error_recomendation
    }

    // MARK: - urls
    public func getURLTerms() -> String {
        guard appConfig != nil, appConfig.general_configuration.terms_condition_url != nil else {
            return nullString
        }
        return appConfig.general_configuration.terms_condition_url
    }

    // MARK: - Avatar
    public func getAvatarImage() -> UIImage! {
        return self.avatarImage
    }

    public func getAvatarGenderID() -> Int {
        guard self.avatar != nil, self.avatar.genderID != nil else { return AvatarGenderIDs.female.rawValue }
        return self.avatar.genderID
    }

    public func getAvatarPieces() -> MyAvatarPieces! {
        return self.avatar
    }

    public func getPiecesList(forPart part: AvatarPiecesIDs) -> Array<AvatarPiece> {

        guard appConfig != nil, appConfig.avatar_pieces_Array != nil, self.avatar != nil, self.avatar.genderID != nil else {
            return []
        }

        var piecesList: Array<AvatarPiece> = []

        for pieces in appConfig.avatar_pieces_Array {
            if pieces.gender == self.avatar.genderID && pieces.body_part == part.rawValue {
                piecesList.append(pieces)
            }
        }

        return piecesList
    }

    // MARK: - PLAN YOUR TRIP
    /**
     - Parameter fromCountry: ID de la nacionalidad o pais de origen
     - Returns: Lista de paises
    */
    public func getCountries(fromCountry id:Int? = UNSELECT_ID) -> Array<Country> {

        guard appConfig != nil, appConfig.countries != nil else {
            return []
        }

        guard id != UNSELECT_ID else {
            return appConfig.countries
        }

        // Filtra lista de paises Excluyendo el pais de origen
        var countries: Array<Country> = []

        for country in appConfig.countries {
            if country.id != id {
                countries.append(country)
            }
        }

        return countries
    }

    // MARK: - USER DATA
    public func getUser() -> UserSerializer! {
        guard let user = userData?.user else { return nil }
        return user
    }

    public func getUserID() -> Int! {
        guard let id = userData?.user?.id else { return nil }
        return id
    }

    public func getUserToken() -> String {
        guard let token = userData?.token else { return nullString }
        return token
    }

    public func getIndex() -> Int {
        guard progress != nil else { return 0 }
        return progress.COURSE_INDEX != nil ? progress.COURSE_INDEX : 0
    }
}
