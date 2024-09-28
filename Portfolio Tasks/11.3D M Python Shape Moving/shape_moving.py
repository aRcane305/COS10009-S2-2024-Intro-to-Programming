import pygame

pygame.init()

SCREEN_HEIGHT = 500
SCREEN_WIDTH = 400
SHAPE_DIM = 50

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
done = False
is_blue = True

# intial box location
x = SCREEN_HEIGHT / 2
y = SCREEN_WIDTH / 2

time = pygame.time
clock = pygame.time.Clock()

while not done:
        clock.tick(60)
        for event in pygame.event.get():
               
                if event.type == pygame.QUIT:
                        done = True
                if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
                        is_blue = not is_blue
        
        pressed = pygame.key.get_pressed()

        # added code to move square up and down the y axis
        if pressed[pygame.K_LEFT]: x -= 3
        if pressed[pygame.K_RIGHT]: x += 3
        if pressed[pygame.K_UP]: y -= 3
        if pressed[pygame.K_DOWN]: y += 3

        # restrict the box within the boundary
        x = max(0, min(x, SCREEN_WIDTH - SHAPE_DIM))
        y = max(0, min(y, SCREEN_HEIGHT - SHAPE_DIM))

        print(f"x is {x} y is {y} timer is {time.get_ticks()}")

        screen.fill((0, 0, 0))
        if is_blue: color = (0, 128, 255)
        else: color = (255, 100, 0)

        # changed dimensions of square to 50x50
        rect = pygame.Rect(x, y, SHAPE_DIM, SHAPE_DIM)
        pygame.draw.rect(screen, color, rect)

        pygame.display.flip()

