import SpriteKit

struct PhysicsCategory {
    static let player: UInt32 = 0
    static let bread: UInt32 = 0b1
    static let rock: UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playerTexture = SKTexture(imageNamed: "jesus")
    let hearthTexture = SKTexture(imageNamed: "hearth-fill")
    var player: SKSpriteNode!
    var ground: SKSpriteNode!
    var isMovingLeft = false
    var rock: SKSpriteNode!
    var bread: SKSpriteNode!
    var hearth1: SKSpriteNode!
    var hearth2: SKSpriteNode!
    var hearth3: SKSpriteNode!
    var isGamePaused = false
    var score = 0
    var highscore = 0
    let scoreLabel = SKLabelNode(text: "Score: 0")
    var pauseButton: SKSpriteNode!
    var currCharacter: Character!
    
    var popUpBg: SKSpriteNode!
    var popUpTitle: SKLabelNode!
    var popUpDesc: SKLabelNode!
    var popUpDesc2: SKLabelNode!
    var popUpImage: SKSpriteNode!
    var popUpButton1: SKSpriteNode!
    var popUpButton2: SKSpriteNode!
    
    func createWelcome(){
        isGamePaused = true
        
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Tutorial"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2 + 170)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "To play this game, you need to know the basic controls. You can move the player character by swiping right or left on the screen. The objective of the game is to collect as many coins as possible to achieve a high score. However, the player must avoid falling objects, particularly rocks, as they will reduce the player's heart. If the player collides with a rock, the player will lose one heart out of the three hearts provided at the beginning of the game. To get a high score, the player must collect coins and avoid rocks for as long as possible. With these basic instructions, you're ready to start playing the game and achieving a high score!"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 320)
        popUpDesc.fontSize = 12
        
        popUpButton1 = SKSpriteNode(imageNamed: "start")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 310)
        popUpButton1.name = "resumeButton"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height + 60
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
        
    }
    
    func createPopUpStory(){
        closePausePopUp()
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "\(currCharacter.charName) Story"
        popUpTitle.position = CGPoint(x: size.width/2, y: size.width/2 + 150)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur viverra vel lectus sed semper. Nam luctus sagittis nisi id dapibus. Sed auctor, orci sit amet rhoncus luctus, libero augue placerat diam, in tempor felis tellus vel nisl. Pellentesque eget risus eu ipsum pharetra consectetur. Quisque nec tincidunt metus, id suscipit enim. Cras dictum vehicula lectus et rutrum. Fusce condimentum pulvinar consequat. Ut sit amet nisl a nulla convallis pellentesque. Phasellus interdum vel arcu vel pretium. Nullam ut risus ex. (1/4, Click next to continue story)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 280)
        popUpDesc.fontSize = 12
        
        popUpButton1 = SKSpriteNode(imageNamed: "next")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 280)
        popUpButton1.name = "next1"
        
        let titleHeight = popUpTitle.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        
        let totalHeight = titleHeight + descHeight + button1Height + 70
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func createPopUpStory2(){
        
    }
    
    func createPausePopUp(){
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 200))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Game is Paused"
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpBg.frame.maxY + 20)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.fontSize = 24
        popUpTitle.zPosition = 101
        
        let currPlayerTexture = SKTexture(imageNamed: currCharacter.charImage)
        popUpImage = SKSpriteNode(texture: currPlayerTexture, size: CGSize(width: 100, height: 100))
        popUpImage.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 70)
        popUpImage.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Character : \(currCharacter.charName)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpImage.frame.maxY - 120)
        popUpDesc.fontSize = 18
        
        popUpButton1 = SKSpriteNode(imageNamed: "story")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 70)
        popUpButton1.name = "storyButton"
        
        popUpButton2 = SKSpriteNode(imageNamed: "resume")
        popUpButton2.size = CGSize(width: 120, height: 40)
        popUpButton2.zPosition = 101
        popUpButton2.position = CGPoint(x: size.width/2, y: popUpButton1.frame.maxY - 70)
        popUpButton2.name = "resumeButton"
        
        let titleHeight = popUpTitle.frame.size.height
        let imageHeight = popUpImage.frame.size.height
        let descHeight = popUpDesc.frame.size.height
        let button1Height = popUpButton1.frame.size.height
        let button2Height = popUpButton2.frame.size.height
        
        let totalHeight = titleHeight + imageHeight + descHeight + button1Height + button2Height + 100
        
        popUpBg.size = CGSize(width: 200, height: totalHeight)
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpImage)
        addChild(popUpDesc)
        addChild(popUpButton1)
        addChild(popUpButton2)
    }
    
    func closePausePopUp(){
        popUpBg.removeFromParent()
        popUpTitle.removeFromParent()
        if popUpImage != nil {
            popUpImage.removeFromParent()
        }
        popUpDesc.removeFromParent()
        popUpButton1.removeFromParent()
        if popUpButton2 != nil{
            popUpButton2.removeFromParent()
        }
    }
    
    func togglePause() {
        isGamePaused = !isGamePaused
        
        if isGamePaused {
            createPausePopUp()
            player.isPaused = true
            rock.isPaused = true
            physicsWorld.speed = 0.0
        } else {
            closePausePopUp()
            player.isPaused = false
            rock.isPaused = false
            physicsWorld.speed = 1.0
        }
    }
    
    func createChar(){
        currCharacter = Character(charName: "Jesus", charImage: "jesus", charStory1: "bikin bumi", charStory2: "mati", charStory3: "naik ke surga")
    }
    
    func createGround(){
        ground = SKSpriteNode(color: UIColor.blue, size: CGSize(width: size.width, height: size.height/8))
        ground.position = CGPoint(x: size.width / 2, y: ground.size.height / 2)
        addChild(ground)
    }

    func createPlayer(){
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 100, height: 100))
        player.position = CGPoint(x: size.width / 2, y: ground.frame.maxY + player.size.height / 2 - 20)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.bread | PhysicsCategory.rock
        player.physicsBody?.collisionBitMask = 0
        addChild(player)
    }
    
    func createHearth() {
        hearth1 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth1.position = CGPoint(x: size.width / 2 - 20, y: frame.maxY - 30)
        hearth2 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth2.position = CGPoint(x: size.width / 2, y: frame.maxY - 30)
        hearth3 = SKSpriteNode(texture: hearthTexture, size: CGSize(width: 15, height: 15))
        hearth3.position = CGPoint(x: size.width / 2 + 20, y: frame.maxY - 30)
        addChild(hearth1)
        addChild(hearth2)
        addChild(hearth3)
    }
    
    func createRock() {
        let rockTexture = SKTexture(imageNamed: "coal")
        rock = SKSpriteNode(texture: rockTexture)
        rock.size = CGSize(width: 25, height: 25) // Atur ukuran objek batu
        let randomX = CGFloat.random(in: rock.size.width...size.width - rock.size.width)
        rock.position = CGPoint(x: randomX, y: size.height)
        rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
        rock.physicsBody?.categoryBitMask = PhysicsCategory.rock
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.player
        rock.physicsBody?.velocity = CGVector(dx: 0, dy: -100) // Atur kecepatan jatuh objek batu
        rock.physicsBody?.linearDamping = 10 // Atur peredaman gesekan pada objek batu
        if !isGamePaused {
            addChild(rock)
        }
    }
    
    func createBread() {
        let breadTexture = SKTexture(imageNamed: "bread")
        bread = SKSpriteNode(texture: breadTexture)
        bread.name = "bread"
        bread.size = CGSize(width: 25, height: 25) // Atur ukuran objek batu
        let randomX = CGFloat.random(in: bread.size.width...size.width - rock.size.width)
        bread.position = CGPoint(x: randomX, y: size.height)
        bread.physicsBody = SKPhysicsBody(rectangleOf: bread.size)
        bread.physicsBody?.categoryBitMask = PhysicsCategory.bread
        bread.physicsBody?.contactTestBitMask = PhysicsCategory.player
        bread.physicsBody?.velocity = CGVector(dx: 0, dy: -100) // Atur kecepatan jatuh objek batu
        bread.physicsBody?.linearDamping = 10 // Atur peredaman gesekan pada objek batu
        if !isGamePaused {
            addChild(bread)
        }
    }
    
    func createPause(){
        let pauseTexture = SKTexture(imageNamed: "pause")
        pauseButton = SKSpriteNode(texture: pauseTexture)
        pauseButton.size = CGSize(width: 50, height: 20)
        pauseButton.position = CGPoint(x: pauseButton.size.width + 40, y: self.frame.size.height - pauseButton.size.height/2 - 10)
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }

    func createScore(){
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.fontColor = UIColor.black
        // menambahkan label ke scene
        addChild(scoreLabel)
    }
    
    func createPopUpGameOver(){
        isGamePaused = true
        popUpBg = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 170))
        popUpBg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpBg.zPosition = 100
        
        popUpTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
        popUpTitle.text = "Game Over"
        popUpTitle.position = CGPoint(x: size.width/2, y: popUpBg.frame.maxY - 50)
        popUpTitle.fontColor = UIColor.black
        popUpTitle.zPosition = 101
        
        popUpDesc = SKLabelNode()
        popUpDesc.text = "Your \(currCharacter.charName) highscore was : \(score)"
        popUpDesc.preferredMaxLayoutWidth = 170
        popUpDesc.numberOfLines = 0
        popUpDesc.fontColor = UIColor.black
        popUpDesc.horizontalAlignmentMode = .center
        popUpDesc.zPosition = 101
        popUpDesc.position = CGPoint(x: size.width/2, y: popUpTitle.frame.maxY - 80)
        popUpDesc.fontSize = 18
        
        popUpButton1 = SKSpriteNode(imageNamed: "retry")
        popUpButton1.size = CGSize(width: 120, height: 40)
        popUpButton1.zPosition = 101
        popUpButton1.position = CGPoint(x: size.width/2, y: popUpDesc.frame.maxY - 70)
        popUpButton1.name = "retryButton"
        
        addChild(popUpBg)
        addChild(popUpTitle)
        addChild(popUpDesc)
        addChild(popUpButton1)
    }
    
    func closePopUpGameOver(){
        popUpBg.removeFromParent()
        popUpTitle.removeFromParent()
        popUpDesc.removeFromParent()
        popUpButton1.removeFromParent()
        if highscore < score {
            highscore = score
        }
        refreshGame()
    }
    
    func refreshGame(){
        isGamePaused = false
        createHearth()
        scoreLabel.text = "Score: 0"
        score = 0
        player.position = CGPoint(x: size.width / 2, y: ground.frame.maxY + player.size.height / 2 - 20)
    }
    
    override func didMove(to view: SKView) {
        
        createWelcome()
        backgroundColor = UIColor.cyan
        
        let waitAction = SKAction.wait(forDuration: 0.7)
        let waitAction5s = SKAction.wait(forDuration: 2)
        
        let createRockAction = SKAction.run(createRock)
        let sequenceAction = SKAction.sequence([createRockAction, waitAction5s])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        run(repeatAction)
        
        let createBreadAction = SKAction.run(createBread)
        let sequenceActionBread = SKAction.sequence([createBreadAction, waitAction])
        let repeatActionBread = SKAction.repeatForever(sequenceActionBread)
        run(repeatActionBread)
        
        
        createChar()
        createGround()
        createPlayer()
        createHearth()
        createPause()
        createScore()
        
        physicsWorld.contactDelegate = self

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.bread {
            contact.bodyB.node?.removeFromParent()
            score += 1
            
            scoreLabel.text = "Score: \(score)"
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.player && contact.bodyB.categoryBitMask == PhysicsCategory.rock {
            contact.bodyB.node?.removeFromParent()
            
            if hearth3.parent != nil {
                hearth3.removeFromParent()
            } else if hearth2.parent != nil {
                hearth2.removeFromParent()
            } else if hearth1.parent != nil {
                hearth1.removeFromParent()
                createPopUpGameOver()
            }
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let detectTouchLeft = player.position.x
            let location = touch.location(in: self)
            if location.x < detectTouchLeft && !isGamePaused {
                if isMovingLeft {
                    player.xScale = 1
                    isMovingLeft = false
                }
                player.position.x -= 3
            } else if location.x > detectTouchLeft && !isGamePaused {
                if !isMovingLeft {
                    player.xScale = -1
                    isMovingLeft = true
                }
                player.position.x += 3
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "retryButton" {
                closePopUpGameOver()
            }
            
            if node.name == "pauseButton"{
                togglePause()
            }
            
            if node.name == "storyButton"{
                createPopUpStory()
            }
            
            if node.name == "resumeButton"{
                togglePause()
            }
            
            if node.name == "next1"{
                createPopUpStory2()
            }
            
        }
    }

}
