
require "assets.data.src.collision"
Enemy = {}

function Enemy.load()
    Snake = {
        X = 70,
        Y = 70,
        W = 32,
        H = 32,
    }
    Eyemotor = {
        X = 300,
        Y = 200,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/EyeMonster.png")
        }
    }
    Eyemotor2 = {
        X = 750,
        Y = 350,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/EyeMonster.png")
        }
    }
    Crab = {
        X = 300,
        Y = 200,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/Crab.png")
        }
    }
    Rat = {
        X = 60,
        Y = 90,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/Rat.png")
        }
    }
    Rat2 = {
        X = 750,
        Y = 350,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/Rat.png")
        }
    }
    Bucket = {
        X = 70,
        Y = 70,
        W = 32,
        H = 32
    }
    Cloak = {
        X = 380,
        Y = 380,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile34.png")
        }
    }
    VooDoo = {
        X = 380,
        Y = 270,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile65.png")
        }
    }
    Pickaxe = {
        X = 380,
        Y = 270,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile23.png")
        }
    }
    MysticalTree = {
        X = 380,
        Y = 270,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile4.png")
        }
    }
    Klue = {
        X = 400,
        Y = 300,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile7.png")
        }
    }
    Ani1 = love.graphics.newImage("assets/images/snake1.png")
    Ani2 = love.graphics.newImage("assets/images/snake2.png")
    BucketSpr = love.graphics.newImage("assets/images/tile63.png")
    CurAni = Ani1
    Talking = false
    ClickOff = false
    Timer = 0
    Dir = false
    Dir2 = false
    KilledAllRats = false
    Rat1ded = false
    Rat2ded = false
    Crab1ded = false
    DirCrab = "Left"
    Eyemotor1Ded = false
    Eyemotor2Ded = false
    DirEyeMoter = "Left"
    DirEyeMoter2 = false
end

function Enemy.update(dt)
    Timer = Timer + dt

    if Timer > 0.5 then
        -- reset the timer
        Timer = 0

        -- switch the face
        if CurAni == Ani1 then
          CurAni = Ani2
        else
          CurAni = Ani1
        end
    end

    --Rat Movement
    if Rat.X > 760 and Dir == true then
        Dir = false
    elseif Rat.X < 1 and Dir == false then
        Dir = true
    end

    if Rat2.X > 760 and Dir2 == true then
        Dir2 = false
    elseif Rat2.X < 10 and Dir2 == false then
        Dir2 = true
    end

    if Dir == true then
        Rat.X = Rat.X + 4
    elseif Dir == false then
        Rat.X = Rat.X - 4
    end
    if Dir2 == true then
        Rat2.X = Rat2.X + 4
    elseif Dir2 == false then
        Rat2.X = Rat2.X - 4
    end

    --Crab Movement
    if DirCrab == "Left" then
        Crab.X = Crab.X + 3
        if Crab.X >= 475 and Crab.Y >= 200 then
            DirCrab = "Down"
        end
    elseif DirCrab == "Down" then
        Crab.Y = Crab.Y + 3
        if Crab.Y >= 346 and Crab.X >= 475 then
            DirCrab = "Right"
        end
    elseif DirCrab == "Right" then
        Crab.X = Crab.X - 3
        if Crab.X <= 300 and Crab.Y >= 346 then
            DirCrab = "Up"
        end
    elseif DirCrab == "Up" then
        Crab.Y = Crab.Y - 3
        if Crab.Y <= 200 and Crab.X <= 300 then
            DirCrab = "Left"
        end
    end

    --eye moter stuff (basically just the crab & rat movement)
    --Eye moter 1:
    if DirEyeMoter == "Left" then
        Eyemotor.X = Eyemotor.X + 3
        if Eyemotor.X >= 475 and Eyemotor.Y >= 200 then
            DirEyeMoter = "Down"
        end
    elseif DirEyeMoter == "Down" then
        Eyemotor.Y = Eyemotor.Y + 3
        if Eyemotor.Y >= 346 and Eyemotor.X >= 475 then
            DirEyeMoter = "Right"
        end
    elseif DirEyeMoter == "Right" then
        Eyemotor.X = Eyemotor.X - 3
        if Eyemotor.X <= 300 and Eyemotor.Y >= 346 then
            DirEyeMoter = "Up"
        end
    elseif DirEyeMoter == "Up" then
        Eyemotor.Y = Eyemotor.Y - 3
        if Eyemotor.Y <= 200 and Eyemotor.X <= 300 then
            DirEyeMoter = "Left"
        end
    end
    --Eye Moter 2:

    if DirEyeMoter2 == true then
        Eyemotor2.X = Eyemotor2.X + 4
    elseif DirEyeMoter2 == false then
        Eyemotor2.X = Eyemotor2.X - 4
    end

    if Eyemotor2.X > 760 and DirEyeMoter2 == true then
        DirEyeMoter2 = false
    elseif Eyemotor2.X < 10 and DirEyeMoter2 == false then
        DirEyeMoter2 = true
    end
end

function Enemy.draw()
    if EastWest == 0 and NorthSouth == 0 then
        love.graphics.draw(CurAni, Snake.X, Snake.Y)
    end

    if Enemy1Dead == true and EastWest == 0 and NorthSouth == 0 then
        love.graphics.draw(BucketSpr, Bucket.X, Bucket.Y)
    end
    if NorthSouth == 6 and EastWest == 4 then
        if Rat1ded == false then
            love.graphics.draw(Rat.Sprite.Image, Rat.X,Rat.Y)
        end
        if Rat2ded == false then
            love.graphics.draw(Rat2.Sprite.Image, Rat2.X, Rat2.Y)
        end
        if Rat1ded == true and Rat2ded == true then
            love.graphics.draw(Cloak.Sprite.Image, Cloak.X, Cloak.Y)
        end
    end
    if NorthSouth == 8 and EastWest == 7 then
        if Crab1ded == false then
            love.graphics.draw(Crab.Sprite.Image, Crab.X, Crab.Y)
        end
        if Crab1ded == true then
            love.graphics.draw(VooDoo.Sprite.Image, VooDoo.X, VooDoo.Y)
        end
    end
    if NorthSouth == 6 and EastWest == 7 then
        if Eyemotor1Ded == false then
            love.graphics.draw(Eyemotor.Sprite.Image, Eyemotor.X, Eyemotor.Y)
        end
        if Eyemotor2Ded == false then
            love.graphics.draw(Eyemotor2.Sprite.Image, Eyemotor2.X, Eyemotor2.Y)
        end
        if Eyemotor1Ded == true and Eyemotor2Ded == true then
            love.graphics.draw(Pickaxe.Sprite.Image, Pickaxe.X, Pickaxe.Y)
        end
    end
    if NorthSouth == 4 and EastWest == 0 then
        love.graphics.draw(MysticalTree.Sprite.Image, MysticalTree.X, MysticalTree.Y)
    end
end