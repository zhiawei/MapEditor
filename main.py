import pygame

(width, height) = (600, 400)
background_colour = (0, 0, 0)

screen = pygame.display.set_mode((width, height), pygame.RESIZABLE)
screen.fill(background_colour)
pygame.display.set_caption('MapEditor')

pygame.display.flip()

running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    screen.fill(background_colour)
    pygame.display.update()
