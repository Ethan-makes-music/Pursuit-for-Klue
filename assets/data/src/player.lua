require "assets.data.src.collision"
require "assets.data.src.enemy"
Player = {}

function Player.load()
    Attacking = false
    Plr = {
        X = 130,
        Y = 130,
        W = 32,
        H = 32
    }
    PlrAni1 = love.graphics.newImage("assets/images/player1.png")
    PlrAni2 = love.graphics.newImage("assets/images/player2.png")
    PlrCurAni = PlrAni1
    PlrTimer = 0
    Talking  = false
    ClickOff = false
    Running = false
end

function Player.update(dt)

    PlrTimer = PlrTimer + dt

    if Running == false then
        if PlrTimer > 0.5 then
            -- reset the timer
            PlrTimer = 0
        
            -- switch the face
            if PlrCurAni == PlrAni1 then
              PlrCurAni = PlrAni2
            else
              PlrCurAni = PlrAni1
            end
        end
    elseif Running == true then
        if PlrTimer > 0.4 then
            -- reset the timer
            PlrTimer = 0
        
            -- switch the face
            if PlrCurAni == PlrAni1 then
              PlrCurAni = PlrAni2
            else
              PlrCurAni = PlrAni1
            end
        end
    end
    --movement & attack stuff
    if love.keyboard.isDown("w") then
        Plr.Y = Plr.Y - 3
        Running = true
    end
    if love.keyboard.isDown("s") then
        Plr.Y = Plr.Y + 3
        Running = true
    end
    if love.keyboard.isDown("a") then
        Plr.X = Plr.X - 3
        Running = true
    end
    if love.keyboard.isDown("d") then
        Plr.X = Plr.X + 3
        Running = true
    end

    if love.keyboard.isDown("space") and love.keyboard.isDown("d") and Attacking == false then
        Plr.X = Plr.X + 30
        Attacking = true
        Laser:play()
    elseif love.keyboard.isDown("space") and love.keyboard.isDown("a") and Attacking == false then
        Plr.X = Plr.X - 30
        Attacking = true
        Laser:play()
    elseif love.keyboard.isDown("space") and love.keyboard.isDown("w") and Attacking == false then
        Plr.Y = Plr.Y - 30
        Attacking = true
        Laser:play()
    elseif love.keyboard.isDown("space") and love.keyboard.isDown("s") and Attacking == false then
        Plr.Y = Plr.Y + 30
        Attacking = true
        Laser:play()
    elseif not love.keyboard.isDown("space") and not love.keyboard.isDown("a") and not love.keyboard.isDown("d") and not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not Attacking == false then
        Attacking = false
        Laser:play()
    end

    if Check_collision(Plr, Bucket) and love.mouse.isDown(2) and Enemy1Dead == true and NorthSouth == 0 and EastWest == 0 then
        Talking = true
        Laser:play()
    end
    if Check_collision(Plr, Cloak) and love.mouse.isDown(2) and Rat1ded == true and Rat2ded == true and NorthSouth == 6 and EastWest == 4 then
        Talking = true
        Laser:play()
    end
    if Check_collision(Plr, VooDoo) and love.mouse.isDown(2) and Crab1ded == true and NorthSouth == 8 and EastWest == 7 then
        Talking = true
        Laser:play()
    end
    if Check_collision(Plr, Pickaxe) and love.mouse.isDown(2) and Eyemotor1Ded == true and Eyemotor2Ded == true and NorthSouth == 6 and EastWest == 7 then
        Talking = true
        Laser:play()
    end
    if Check_collision(Plr, MysticalTree) and love.mouse.isDown(2) and Eyemotor1Ded == true and Eyemotor2Ded == true and NorthSouth == 4 and EastWest == 0 then
        Talking = true
        Laser:play()
    end
    if Check_collision(Plr, Klue) and love.mouse.isDown(2) and SeeLast == true and NorthSouth == 1 and EastWest == 1 then
        Talking = true
        Laser:play()
    end
    --Collision stuf
end

function Player.draw()
    love.graphics.draw(PlrCurAni, Plr.X, Plr.Y)

    if Enemy1Dead == true and Talking == true and Check_collision(Plr, Bucket) and EastWest == 0 and NorthSouth == 0 then
        love.graphics.print("Its a water Bucket, it shows he may have been\nnear the 3 3 lake", 100, 500)
        ClickOff = true
    end

    if Rat1ded and Rat2ded and Talking == true and Check_collision(Plr, Cloak) and NorthSouth == 6 and EastWest == 4 then
        love.graphics.print("Its the cloak of Crab that means he must have been at the\n8 7 House of Crabs", 100,500)
    end

    if Crab1ded == true and Talking == true and Check_collision(Plr, VooDoo) and NorthSouth == 8 and EastWest == 7 then
        love.graphics.print("Its a voodoo doll made by the The house of eye\nthat means he may have been near the 6 7 house of eyes", 100,500)
    end

    if Eyemotor1Ded == true and Eyemotor2Ded == true and Talking == true and Check_collision(Plr, Pickaxe) and NorthSouth == 6 and EastWest == 7 then
        love.graphics.print("Its a Pickaxe thats means he was at the 4 0 mine!", 100, 500)
    end

    if Eyemotor1Ded == true and Eyemotor2Ded == true and Talking == true and Check_collision(Plr, MysticalTree) and NorthSouth == 4 and EastWest == 0 then
        love.graphics.print("Oh, Hi! I am the Mystical Tree!\nOh your looking for Klue? last time I saw him was in the 1 1 forest.\nWish you luck!", 100, 500)
        SeeLast = true
    end

    if SeeLast ==  true and Talking == true and Check_collision(Plr, Klue) and NorthSouth == 1 and EastWest == 1 then
        love.graphics.print("I just got spat out by the trees thank you so much for saving me! Wait? \nwere you expecting I was a human? How rude", 0, 500)
        love.timer.sleep(3)
        GameState = "end"
    end

    if ClickOff == true and Talking == true and love.mouse.isDown(1) then
        Talking = false
    end
end