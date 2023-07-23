require "assets.data.src.player"
require "assets.data.src.enemy"
require "assets.data.src.collision"
require "assets.data.src.talkables"

function love.load()
    Music = love.audio.newSource("assets/sounds/corn.wav", "stream")
    Explosion = love.audio.newSource("assets/sounds/Explosion.wav", "static")
    Laser = love.audio.newSource("assets/sounds/Laser.wav", "static")
    Music:setLooping(true)
    Player.load()
    Enemy.load()
    Talkables.load()
    Bg = love.graphics.newImage("assets/images/bg.png")
    EastWest = 0
    NorthSouth = 0
    GameState = "menu"
    Selected = "start"
    Enemy1Dead = false
    AbleToKill = false
    ButtonStart = {
        X = 300,
        Y = 320,
        W = 96,
        H = 32,
        Speed = 2
    }
    ButtonAbout = {
        X = 310,
        Y = 109,
        W = 96,
        H = 32
    }
    Tree = {
        X = 500,
        Y = 300,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile51.png")
        }
    }
    Tree2 = {
        X = 500,
        Y = 300,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile51.png")
        }
    }
    Tree3 = {
        X = 500,
        Y = 300,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile51.png")
        }
    }
    Tree4 = {
        X = 500,
        Y = 300,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile51.png")
        }
    }
    SeeLast = false
    Image1 = love.graphics.newImage("assets/images/ButtonStart1.png")
    Image2 = love.graphics.newImage("assets/images/ButtonStart2.png")
    Cur = Image1
    StartY = 100
end

function love.update(dt)
    --Sine wave stuff (for future me lmao)
    ButtonStart.Y = ButtonStart.Y + math.sin(love.timer.getTime() * ButtonStart.Speed) * 1
    if ButtonStart.Y > love.graphics.getHeight() then
        ButtonStart.Y = Image2:getHeight()
        StartY = 0
    end

    --GameState
    if GameState == "game" then
        Player.update(dt)
        Enemy.update(dt)
        Talkables.update(dt)

        if Check_collision(Plr, Snake) and Attacking == false and Enemy1Dead == false and EastWest == 0 and NorthSouth == 0 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Snake) and  Attacking == true and Enemy1Dead == false and EastWest == 0 and NorthSouth == 0 then
            Snake.Y = 1500
            Enemy1Dead = true
            Explosion:play()
        end

        if Check_collision(Plr, Eyemotor2) and Attacking == false and Eyemotor2Ded == false and EastWest == 7 and NorthSouth == 6 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Eyemotor2) and Attacking == true and Eyemotor2Ded == false and EastWest == 7 and NorthSouth == 6 then
            Eyemotor2.Y = 1500
            Eyemotor2Ded = true
            Explosion:play()
        end

        if Check_collision(Plr, Eyemotor) and Attacking == false and Eyemotor1Ded == false and EastWest == 7 and NorthSouth == 6 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Eyemotor) and Attacking == true and Eyemotor1Ded == false and EastWest == 7 and NorthSouth == 6 then
            Eyemotor.Y = 1500
            Eyemotor1Ded = true
            Explosion:play()
        end

        if Check_collision(Plr, Crab) and Attacking == false and Crab1ded == false and NorthSouth == 8 and EastWest == 7 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Crab) and Attacking == true and Crab1ded == false and NorthSouth == 8 and EastWest == 7 then
            Crab.Y = 1500
            Crab1ded = true
            Explosion:play()
        end

        if Check_collision(Plr, Rat) and Attacking == false and Rat1ded == false and EastWest == 4 and NorthSouth == 6 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Rat) and Attacking == true and Rat1ded == false and EastWest == 4 and NorthSouth == 6 then
            Rat.X = 1500
            Rat1ded = true
            Explosion:play()
        end

        if Check_collision(Plr, Rat2) and Attacking == false and Rat2ded == false and EastWest == 4 and NorthSouth == 6 then
            love.load()
            Explosion:play()
        elseif Check_collision(Plr, Rat2) and Attacking ==  true and Rat2ded == false and EastWest == 4 and NorthSouth == 6 then
            Rat2.X = 1500
            Rat2ded = true
            Explosion:play()
        end

        --Directory
        if Plr.Y <= -20 then
            NorthSouth = NorthSouth + 1
            Plr.Y = 567
        elseif Plr.Y >= 568 then
            NorthSouth = NorthSouth - 1
            Plr.Y = 0
        elseif Plr.X >= 764 then
            EastWest = EastWest + 1
            Plr.X = -5
        elseif Plr.X <= -4 then
            EastWest = EastWest - 1
            Plr.X = 763
        end
    end
    if GameState == "menu" then
        if love.keyboard.isDown("x") and Selected == "start" then
            GameState = "game"
        end
        if love.keyboard.isDown("down") and Selected == "start" then
            Selected = "about"
        elseif love.keyboard.isDown("up") and Selected == "about" then
            Selected = "start"

        end

        if Selected == "start" then
            --Start
            Cur = Image1
        elseif Selected == "about" then
            --Start
            Cur = Image2
        end
    end
    if love.keyboard.isDown("escape") then
        GameState = "menu"
    end
end

function love.draw()
    KennyFont = love.graphics.newFont("assets/fonts/Kenney Blocks.ttf", 15)
    KenneyFont2 = love.graphics.newFont("assets/fonts/Kenney Blocks.ttf", 35)
    love.graphics.setFont(KennyFont)
    if GameState == "game" then
        Music:play()
        love.graphics.draw(Bg, 0, 0)
        Player.draw()
        Talkables.draw()
        Enemy.draw()
        love.graphics.print("North/South: " ..tostring(NorthSouth), 0,0)
        love.graphics.print("East/West: " ..tostring(EastWest), 0,20)
        if EastWest == 1 and NorthSouth == 1 then
            love.graphics.draw(Tree.Sprite.Image, Tree.X, Tree.Y)
            love.graphics.draw(Tree2.Sprite.Image, Tree2.X, Tree2.Y)
            love.graphics.draw(Tree3.Sprite.Image, Tree3.X, Tree3.Y)
            love.graphics.draw(Tree4.Sprite.Image, Tree4.X, Tree4.Y)
            if SeeLast == true then
                love.graphics.draw(Klue.Sprite.Image, Klue.X, Klue.Y)
            end
        end

        if not EastWest == 0 and NorthSouth == 0 or not EastWest == 3 and NorthSouth == 3 or not EastWest == 4 and NorthSouth == 6 or not EastWest == 7 and NorthSouth == 8 or not NorthSouth == 6 and EastWest == 7 or not NorthSouth == 4 and EastWest == 0 or not NorthSouth == 1 and EastWest == 1 then
            love.graphics.draw(Tree.Sprite.Image, Tree.X, Tree.Y)
            love.graphics.draw(Tree2.Sprite.Image, Tree2.X, Tree2.Y)
            love.graphics.draw(Tree3.Sprite.Image, Tree3.X, Tree3.Y)
            love.graphics.draw(Tree4.Sprite.Image, Tree4.X, Tree4.Y)
        end
    end
    if GameState == "menu" then
        love.graphics.draw(Bg)
        love.graphics.setFont(KenneyFont2)
        love.graphics.print("Pursuit for Klue", 215,StartY)
        love.graphics.draw(Cur, ButtonStart.X, ButtonStart.Y)
        Music:play()
    end
    if GameState == "end" then
        love.graphics.print("Thank You so much for playing!\nMake sure to play other Kenney Jam games!", 400,300)
        love.graphics.print("(press esc to quit to menu)", 250, 600)
        Music:play()
    end
end