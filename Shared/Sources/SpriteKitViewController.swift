//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import SpriteKit

final private class IBAScene: SKScene {
  override required init(size: CGSize) {
    super.init(size: size)

    self.addChild(self.helloWorldLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.addChild(self.helloWorldLabel)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    touches.forEach {
      let location = $0.locationInNode(self)
      self.addSpaceshipAtLocation(location)
    }
  }

  // MARK: Private

  private lazy var helloWorldLabel: SKLabelNode = {
    let label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    label.text = NSLocalizedString("Tap to add sprite", comment: "SpriteKitViewController background label")
    label.fontSize = 28
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    return label
  }()

  private func addSpaceshipAtLocation(location: CGPoint) {
    let spaceShip = SKSpriteNode(imageNamed: "spritekit_reveal")
    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration: 1)

    spaceShip.position = location
    spaceShip.runAction(SKAction.repeatActionForever(action))

    self.addChild(spaceShip)
  }
}

final class SpriteKitViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure the view
    self.skView.showsFPS = true
    self.skView.showsNodeCount = true

    // Create and configure the scene
    let scene = IBAScene(size: self.skView.bounds.size)
    scene.scaleMode = .AspectFill

    self.skView.presentScene(scene)
  }

  // MARK: Private

  private var skView: SKView {
    return self.view as! SKView
  }
}
