extends Node

# When a ball should start
signal sigBallShoot

# When a ball should be removed
signal sigBallRemoved(ball : Node2D)

# When no more balls on screen
signal sigNoBallsRemaining

# When a ball collide on object
signal sigBallsCollided(collider : Node2D, ball : Node2D)

# When aiming with the mouse
signal sigMouseAiming(pos : Vector2)

# Stop aiming
signal sigStopAiming

# Abort aiming
signal sigAbortAiming

# Start Moving bricks
signal sigStartMovingBricks

# End moving bricks one level (can be repeated after level 50)
signal sigEndMovingBricks

# End of state for moving bricks
signal sigEndStateMovingBricks

# indicate the next level
signal sigNextLevel(level : int)

# Add points to score
signal sigAddScorePoints(points : int)

# Add a new ball
signal sigAddNewBall

# End of game
signal sigEndOfGame

# Changed the speed factor
signal sigSpeedFactorChanged(speed_factor : float)
