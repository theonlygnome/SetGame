# SetGame
## SwiftUI Implementation of the game SET!

This game is implmented against the requirements in the assignment for [Stanford's cs193p, Spring 2023](https://cs193p.sites.stanford.edu/2023), and some code, specifically AspectVGrid and Cardify (which is not being used in this game at this time), was written by the Professor (note I am not a student and have been watching the course on YouTube)

### Examples of the game using an unshuffled deck

#### When a matched set has been selected, the cards will rotate once and show a grey background:

<img src="https://github.com/theonlygnome/SetGame/assets/95313083/54ec1fb4-9d0c-458a-b3bb-701429df4e97" width="200" height="400">

#### When a mismatched set has been selected, the cards will shake momentarily and show a light red background:

<img src="https://github.com/theonlygnome/SetGame/assets/95313083/da580140-a42c-4802-9f29-9b16cb1c90e6" width="200" height="400">

### Current bugs:
* "Deal" deck is face up.  I can make it "face down" but it wasn't animating flipping and dealing the cards one at a time.  Still working on this.
* The contents of the cards are indiscernable if all 81 cards are dealt.  This could be dealt with by adding scrolling but playing the game and making matches renders this relatively unnecessary. 

