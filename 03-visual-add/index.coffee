'use strict'

exports.add = (arr) ->
	digit = if arr.length then +(arr.join '') else 0
	strDigit = (digit+1).toString()
	return (strDigit[i] for i in [0...strDigit.length])

