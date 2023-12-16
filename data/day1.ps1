###############################################################################
# Advent of Code 2023: Day 1
# Version: 0.3
# Author: Infrasaurus
# Last Modified: 15-DEC-2023
###############################################################################
# Import the problem text
$input = Get-Content ".\data\problems\trebuchet.txt"
# Initialize the $solution variable
$solution = 0
# Create function to solve the problem, line by line
function linesolve {
    # Defines the line input as a string
    param (
        [string]$string
    )
    # Regex matches for all digits in the line
    $numbers = [regex]::Matches($string, '(\d)')
    # For all lines with integer count > 0, grabs first and last digit
    if ($numbers.Count -gt 0) {
        $first = $numbers[0].Value.ToLower()
        Write-Host $first
        $last = $numbers[$numbers.Count - 1].Value.ToLower()
        Write-Host $last
        # Combines $first and $last into single integer
        [int]$combined = [int]("$first$last")
        Write-Output $combined
    }
}
# Create function to combine line solutions into a puzzle solution
function puzzlesolve {
    param (
        [int]$sum,
        [int]$currentsum
    )
    $currentsum += $sum
    Write-Output $currentsum
}
# Parse the problem text line by line, then add each line solution to ongoing total
ForEach ($line in $input) {
    # Sanitize data for simpler regex by replacing strings with integers where appropriate
    # Lines 43 through 52 aren't used for Day 1, Part 1's solution
    $line = $line `
        -replace "one","o1e" `
        -replace "two","t2o"`
        -replace "three","t3e"`
        -replace "four","f4r"`
        -replace "five","f5e"`
        -replace "six","s6x"`
        -replace "seven","s7n"`
        -replace "eight","e8t"`
        -replace "nine","n9e"
    $increment = linesolve -string $line
    Write-Host "Incrementing by $increment..."
    $solution = puzzlesolve -sum $increment -currentsum $solution
    Write-Host "Current value: $solution"
}
Write-Host "If my calculations are correct, the solution is $solution!"