fs = require 'fs'


GEO_FIELD_MIN = 0
GEO_FIELD_MAX = 1
GEO_FIELD_COUNTRY = 2


exports.ip2long = (ip) ->
  ip = ip.split '.', 4
  return +ip[0] * 16777216 + +ip[1] * 65536 + +ip[2] * 256 + +ip[3]


gindex = []
exports.load = ->
  data = fs.readFileSync "#{__dirname}/../data/geo.txt", 'utf8'
  data = data.toString().split '\n'

  for line in data when line
    line = line.split '\t'
    # GEO_FIELD_MIN, GEO_FIELD_MAX, GEO_FIELD_COUNTRY
    gindex.push [+line[0], +line[1], line[3]]

  gindex.sort (a, b) -> return a[GEO_FIELD_MIN] - b[GEO_FIELD_MIN]

normalize = (row) -> country: row[GEO_FIELD_COUNTRY]


exports.lookup = (ip) ->
  return -1 unless ip

  find = this.ip2long ip

  minIndex = 0
  maxIndex = gindex.length - 1
  curIndex = 0


  while minIndex <= maxIndex
    curIndex = Math.floor( (minIndex + maxIndex) / 2 )
    line = gindex[curIndex]

    if find < line[GEO_FIELD_MIN]
      maxIndex = curIndex - 1
    else if find > line[GEO_FIELD_MAX]
      minIndex = curIndex + 1
    else
      return normalize line

  return null
