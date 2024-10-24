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

# Abort aiming
signal sigAbortAiming
