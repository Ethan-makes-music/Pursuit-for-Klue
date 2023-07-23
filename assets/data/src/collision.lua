Check_collision = {}

function Check_collision(a, b)
    return a.X < b.X + b.W and
           a.X + a.W > b.X and
           a.Y < b.Y + b.H and
           a.Y + a.H > b.Y
  end