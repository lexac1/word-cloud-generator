# Word Cloud Generator

## Objective

  Review documents to get a report of the topics and keywords

## Output

  A count of each word in a given document that can be used to see senitment or general topics mentioned

## Versions

  Ruby script version that operates on a text file and text file template below

  Google script version that operates on a google doc

## Usage

**Requires Ruby to be installed**

In a terminal window run a similar command

Example usage

`ruby histogram.rb ../../../writings/reviews/2020_yearly.md ../../../writings/reviews/yearly_template.md`

With template:

`ruby histogram.rb path/to/input_file path/to/template_file`

Without template:

`ruby histogram.rb path/to/input_file`
