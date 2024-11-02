extends Node

# Entering a StateMachine state
signal sigEnterState(state : String)

# Exiting a StateMachine state
signal sigExitState(state : String)

# When a ball should start
signal sigBallShoot

# When a ball should be removed
signal sigBallRemoved(ball : Node2D)

# When the ball count is updated
signal sigBallCountUpdated(ball_count : int)

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

# indicates that the maximum level has been reached
signal sigMaxLevel(max_level : int)

# Add points to score
signal sigAddScorePoints(points: int)

# When score points is updated
signal sigScorePointsUpdated

# Add a new ball
signal sigAddNewBalls(balls: int)

# End of game
signal sigEndOfGame

# Changed the speed factor
signal sigSpeedFactorChanged(speed_factor : float)

# Bonus replay updated
signal sigReplayBonusUpdated(bonus : int)
