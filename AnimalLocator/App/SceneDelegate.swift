//
//  SceneDelegate.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        let viewController = MainAssembly.makeViewController()
        self.setupWindow(in: scene, with: UINavigationController(rootViewController: viewController))
    }

    private func setupWindow(in scene: UIWindowScene, with viewController: UIViewController) {

        let window = UIWindow(windowScene: scene)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
