import pygame
import sys

#Color
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)

resolution = (WIDTH, HEIGHT) = (600, 400)
background_colour = (BLACK)
clock = pygame.time.Clock()

pygame.init()
SCREEN = pygame.display.set_mode(resolution, pygame.RESIZABLE)
SCREEN.fill(background_colour)
pygame.display.set_caption('MapEditor')

pygame.display.flip()

def drawGrid():
    blockSize = 20 #Set the size of the grid block
    for x in range(0, WIDTH, blockSize):
        for y in range(0, HEIGHT, blockSize):
            rect = pygame.Rect(x, y, blockSize, blockSize)
            pygame.draw.rect(SCREEN, WHITE, rect, 1)

while True:
    clock.tick(60)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    SCREEN.fill(background_colour)
    drawGrid()
    pygame.display.flip()

