require "assets.data.src.collision"
require "assets.data.src.player"

Talkables = {}

function Talkables.load()
    Talking = false
    WhosTalking = "noone"
    ClickOff = false
    Person1 = {
        X = 200,
        Y = 90,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile_0005.png")
        }
    }
    Person2 = {
        X = 400,
        Y = 150,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile_0007.png")
        }
    }
    Note = {
        X = 650,
        Y = 350,
        W = 32,
        H = 32,
        Sprite = {
            Image = love.graphics.newImage("assets/images/tile48.png")
        }
    }
end

function Talkables.update(dt)
    if Check_collision(Plr, Person1) and love.mouse.isDown(2) and EastWest == 0 and NorthSouth == 0 then
        Talking = true
        WhosTalking = "Person1"
    end
    if Check_collision(Plr, Person2) and love.mouse.isDown(2) and NorthSouth == 3 and EastWest == 3 then
        Talking = true
        WhosTalking = "Person2"
    end
    if Check_collision(Plr,Note) and love.mouse.isDown(2) and EastWest == 3 and NorthSouth == 3 then
        Talking = true
        WhosTalking = "Note"
    end
end

function Talkables.draw()
    if  EastWest == 0 and NorthSouth == 0 then
        love.graphics.draw(Person1.Sprite.Image, Person1.X, Person1.Y)
    end

    if WhosTalking == "Person1" and Talking == true and Check_collision(Plr, Person1) and EastWest == 0 and NorthSouth == 0 then
        love.graphics.print("Welcolme to the game \nkill monsters and talk to NPC to figure out the case of Klue", 100, 500)
        ClickOff = true
    end
    if WhosTalking == "Person2" and Talking == true and Check_collision(Plr, Person2) and EastWest == 3 and NorthSouth == 3 then
        love.graphics.print("Idk man The lake has been dried up for years BUT LOOK AT THESE PECS", 100,500)
        ClickOff = true
    end
    if WhosTalking == "Note" and Talking == true and Check_collision(Plr, Note) and EastWest == 3 and NorthSouth == 3 then
        love.graphics.print("Its a old cross that Klue used to take everywhere\nso he may be at the  6 4 Semetery", 100,500)
    end
    if ClickOff == true and Talking == true and love.mouse.isDown(1) then
        Talking = false
    end

    if EastWest == 3 and NorthSouth == 3 then
        love.graphics.draw(Person2.Sprite.Image, Person2.X, Person2.Y)
        love.graphics.draw(Note.Sprite.Image, Note.X, Note.Y)
    end
end