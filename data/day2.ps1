###############################################################################
# Advent of Code 2023: Day 2
# Version: 0.2
# Author: Infrasaurus
# Last Modified: 15-DEC-2023
###############################################################################
# Import the problem text
$input = Get-Content ".\data\problems\cubes.txt"
# Set maximum values for red, green, and blue cubes
[int]$tred = 12
[int]$tgreen = 13
[int]$tblue = 14
# Initialize remaining integer variables to ensure correct arithmetic.
[int]$game = 0
[int]$gtotal = 0
[int]$gpower = 0
[int]$tpower = 0
ForEach ( $line in $input ) {
    # Initialize counts for input sanitizing
    $red = 0
    $green = 0
    $blue = 0
    $rfail = $false
    $gfail = $false
    $bfail = $false
    # Get counts for red, green and blue on each line
    $red = [regex]::Matches($line, '(\d+)\sred') | ForEach-Object { $_.Groups[1].Value }
    $green = [regex]::Matches($line, '(\d+)\sgreen') | ForEach-Object { $_.Groups[1].Value }
    $blue = [regex]::Matches($line, '(\d+)\sblue') | ForEach-Object { $_.Groups[1].Value }
    $game = [regex]::Matches($line, 'Game (\d+)') | ForEach-Object { $_.Groups[1].Value }
    # Compares each array value against the maximum number of colored cubes
    # If $num is higher than $tmax, sets a fail flag to $true
    ForEach ($num in $red) {
        if ([int]$num -gt $tred) {
            $rfail = $true
            #Write-Host "Red count is impossible in game $game"
            break
        }
    }
    ForEach ($num in $green) {
        if ([int]$num -gt $tgreen) {
            $gfail = $true
            #Write-Host "Green count is impossible in game $game"
            break
        }
    }
    ForEach ($num in $blue) {
        if ([int]$num -gt $tblue) {
            $bfail = $true
            #Write-Host "Blue count is impossible in game $game"
            break
        }
    }
    # Increments $gtotal by game number only if all failure flags are $false
    if (( $rfail -like $false ) -and ( $gfail -like $false ) -and ( $bfail -like $false )) {
        Write-Host "Incrementing count by $game..."
        [int]$gtotal += [int]$game
    } else {
        Write-Host "$game would have been impossible."
    }
    # PART 2 ONLY: Gets largest value from each array
    [int]$mred = ($red | Measure-Object -Maximum).Maximum
    [int]$mgreen = ($green | Measure-Object -Maximum).Maximum
    [int]$mblue = ($blue | Measure-Object -Maximum).Maximum
    # Multiples each mvalue together to get the power of that game
    $gpower = $mred * $mgreen * $mblue
    $tpower += $gpower
}
Write-Host "The solution for part 1 should be $gtotal."
Write-Host "The solution for part 2 should be $tpower."