//
//  CallManager.swift
//  MyFacetime
//
//  Created by Fawaz Tarar on 4/27/24.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class CallManager {
    static let shared = CallManager()

    struct Constants {
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUXVpLUdvbl9KaW5uIiwiaXNzIjoiaHR0cHM6Ly9wcm9udG8uZ2V0c3RyZWFtLmlvIiwic3ViIjoidXNlci9RdWktR29uX0ppbm4iLCJpYXQiOjE3MDc4NTkwNTIsImV4cCI6MTcwODQ2Mzg1N30.Hd4sYqPILhZCsuOsR1Afnc45pF4wUF7-zpwWYsFOI7s"
    }

    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var callViewMoel: CallViewModel?

    struct UserCredentials {
        let user: User
        let token: UserToken
    }

    func setUp(email: String) {
        setUpCallViewModel()
        // UserCredential
        let credential = UserCredentials(
            user: .guest(email),
            token: UserToken(rawValue: Constants.userToken)
        )
        // StreamVideo
        let video = StreamVideo(
            apiKey: "5jumt68yz6kj",
            user: credential.user,
            token: credential.token) { result in
                // Refresh token via real backend
                result(.success(credential.token))
            }
        // StreamVideUI
        let videoUI = StreamVideoUI(streamVideo: video)

        self.video = video
        self.videoUI = videoUI
    }

    private func setUpCallViewModel() {
        guard callViewMoel == nil else { return }
        DispatchQueue.main.async {
            self.callViewMoel = CallViewModel()
        }
    }
}
