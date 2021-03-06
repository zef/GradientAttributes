# GradientAttributes

A Swift library that simplifies the use of a CAGradientLayer.

## Why?

Creating attributes for a CAGradientLayer can be tedious:

- Colors and Locations array must be typed as `[AnyObject]`
- Colors and Locations are provided by separate arrays instead of together as a pair of related values.
- Colors must return `CGColor` as values
- Changing the direction of a gradient to common directions is non-obvious and unclear when reading code.
- A location value must be provided along with each color, which could be tedious to maintain.

GradientAttributes improves this experience by providing a nicer syntax for defining color stops, as well as providing additional logic to interpolate location values so you only need to provide what you care about.

## How?

For now, see [the tests](https://github.com/zef/GradientAttributes/blob/master/GradientAttributesTests/GradientAttributesTests.swift) and [code](https://github.com/zef/GradientAttributes/blob/master/GradientAttributes/GradientAttributes.swift) for usage details.

## TODO

- [ ] Document usage in README
- [ ] Expand options for setting direction beyond simply Horizontal/Vertical. Probably will be able to specify common start and end locations.
- [ ] Verify that this can be installed as a framework.
- [ ] Add .playground that demonstrates usage. Currently having problems importing module into the playground.
- [ ] See if there's a better syntax for defining gradient stops in an array. 
