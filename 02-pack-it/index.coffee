
exports.pack = (data, cb) ->
  buffer = new Buffer(128)

  buffer[i] = 0 for i in [0..buffer.length-1] by 1

  for item, index in data
    byte = Math.floor index / 8
    bit = index % 8

    buffer[byte] |= (if item is true then 1 else 0) << bit

  cb null, buffer


exports.unpack = (buffer, cb) ->
  data = []

  for i in [0..buffer.length-1] by 1
    for j in [0..7] by 1
      data.push if ( buffer[i] >>> j & 0x01 ) then true else false

  cb null, data

