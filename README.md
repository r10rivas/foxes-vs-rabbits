Foxes vs Rabbits is a challenge/game aimed at demonstrating the skills and knowledge acquired on programming. The technical bases for the realization of the project are the following:

* Use only ruby language.
* Do not use idiomatic methods or classes (each, map, hash, etc)
* Exceptions:
  * Use the rand () method where some random processing is required.
  * The Ruby system ("clear") instruction is used to clear the console (terminal) and can be placed anywhere in the source code.
  * You can make use of the Gem Colorize to manipulate the color of the displayed texts, in order to make the outputs of your program more expressive.
  
## Table of Contents
- [Game description](#game-description)
- [General rules of the game](#general-rules-of-the-game)
- [Challenge description](#challenge-description)

## Game description
In the surroundings of a farm where various kinds of vegetables are produced, there is a population of rabbits that frequently enter the cultivated fields to feed and reproduce, ending these crops. The owners of these fields have chosen to allow the entry of wild foxes in the area, so that they serve as a mechanism to control the plague that rabbits have become. However, the permanence of these foxes in the surroundings of the crops will depend on their effectiveness in the extermination of these voracious and horny rabbits.

Foxes vs Rabbits game is a playful representation of the battle between these two local animals, in which the rabbits must reach the harvest location in order to survive. The foxes, in turn, must prevent the arrival of the rabbits, hunting them before they enter the cultivated fields.

## General rules of the game

The game takes place on a checkered board that represents the path to the harvest, with a width configurable by the user and no less than 5 squares and a fixed height of 15 squares, where the rabbits run at maximum speed towards their objective, trying to avoid the coyotes that run towards them and, which they cannot see, given the road conditions. The coyotes, in turn, run in a straight line and in the opposite direction to the displacement of the rabbits, also with zero visibility, trying to coincide with one or more on their way and in this way, exterminate them in order to remain on the farm. Rabbits, because they are so elusive, can change direction. This change of direction is carried out by all the rabbits at the same time, because, seeing that one of the rabbits changes direction, instinctively, the other rabbits copy this movement.

As rules of the game Foxes and Rabbits, there are the following:
1. There are male and female rabbits, in equal proportions.
2. The rabbits move in the direction of the harvest.
3. The foxes only move in the opposite direction to the harvest; never sideways.
4. Both rabbits and foxes must move only one square per play.
5. Each animal occupies a single square on the board, and one square is only occupied by one animal at a time.
6.Rabbits can change direction wherever the player user indicates. This change of direction consists of moving each rabbit one square to the left or right, as indicated by the player, and only if the rabbit has an available space in the indicated direction. The rabbits located at the edges of the board will not be able to change direction towards that edge, since, obviously, there are no squares to move it to.
7. When a rabbit and a fox coincide in a square, the fox "eats" the rabbit. That is, deduct it from the total number of live rabbits, prevent it from continuing to make movements and not show it on the board during the remaining plays. Likewise, it must be visually indicated during that play that the fox has hunted the rabbit in that square.
8.Each fox that matches a rabbit loses one move while devouring it, that is, sacrifices one (1) forward move when hunting the rabbit.
9. The game ends when among the surviving rabbits there is not at least one female and one baron, or all the surviving rabbits have reached the harvest, or when all the rabbits are hunted by the foxes.
10. The player user wins the game when at least one (1) male rabbit and one (1) female rabbit reach the harvest, thus making the group survive. In any other case, the user loses the game, thus allowing the coyotes to remain on the ranch.

At all times, the user must be able to visualize the location of each surviving rabbit. Also, it should be visually appreciated when a rabbit is hunted by a fox. Once the game is over, the user must be told whether he won or lost the game.

## Challenge description
The challenge is to create a program that implements a version of the game Foxes vs Rabbits, which allows one (1) player to play, respecting the rules of the game previously described, keeping control of each play, and finally, showing the final results and indicating who wins (foxes or rabbits).

The game takes place in phases. First, the user must be asked how wide the board will be and, for the purposes of this project, the number of rabbits and foxes that the game will have. Once these data have been entered, the program should show the board ready to start playing; that is, with the rabbits and foxes located in random starting positions, even though the foxes will not be visible.

The user will begin to play, indicating if he wants to move the rabbits in any direction (with the arrow keys of the corresponding keyboard) or simply, move forward towards the harvest (with the "Enter" key of the keyboard, for example), being able to observe , then, the updated board with the indicated rabbit movement.

If some of the rules specified above are met to end the game, the program will show the board somehow identifying the squares where the deaths of some rabbits occurred (if any), the squares where both the foxes and the surviving rabbits are located and if the user lost or won.