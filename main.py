import pygame
import sys

#Color
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
GREEN = (0, 255, 0)

resolution = (WIDTH, HEIGHT) = (1280, 800)
background_colour = (BLACK)
FPS = 60

blockSize = 40

# Initialize
pygame.init()
pygame.font.init()
SCREEN = pygame.display.set_mode(resolution, pygame.RESIZABLE)
FONTS = pygame.font.SysFont('Comic Sans MS', 20)
clock = pygame.time.Clock()
pygame.display.set_caption('MapEditor')
text_surface = FONTS.render('Some Text', False, (255, 0, 0))

canvas = pygame.Surface(resolution)
infobox = pygame.Rect(0, 0, 800, 40)
Gridbox = pygame.Rect(0, 40, 800, 800)
Tilebox = pygame.Rect(800, 0, 1280, 800)
#infobox = pygame.Rect(0, 0, 800, 100)


def drawGrid(infoObject):
    #WIDTH = infoObject.current_w
    #HEIGHT = infoObject.current_h
    WIDTH = Gridbox.width
    HEIGHT = Gridbox.height
    for x in range(0, WIDTH, blockSize):
        for y in range(40, HEIGHT, blockSize):
            rect = pygame.Rect(x, y, blockSize, blockSize)
            pygame.draw.rect(SCREEN, WHITE, rect, 1)

while True:
    clock.tick(FPS)
    frames = clock.get_fps()
    infoObject = pygame.display.Info()
    text_surface = FONTS.render(f'height: {infoObject.current_h}, width: {infoObject.current_w}, FPS: {int(frames)}', False, (255, 255, 0))

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    SCREEN.fill(background_colour)
    SCREEN.fill(RED, infobox)
    SCREEN.fill(BLUE, Tilebox)
    drawGrid(infoObject)
    SCREEN.blit(text_surface, (0,0))
    pygame.display.flip()
    infoObject = pygame.display.Info()
    


