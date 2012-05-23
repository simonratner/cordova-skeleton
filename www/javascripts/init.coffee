
window.init = ($) ->
  $('#platform').html "#{device.platform} #{device.version}"
  $('#device').html device.name
  $('#uuid').html device.uuid
  $('#width').html screen.width
  $('#height').html screen.height
  $('#colorDepth').html screen.colorDepth
  $(window).on 'resize', (e) ->
    $('#width').html screen.width
    $('#height').html screen.height

  round = (num, prec = 3) ->
    return num if typeof num != 'number'
    Math.round(num * Math.pow(10, prec)) / Math.pow(10, prec)

  onAccelerometer = (a) ->
    $('#x').html round(a.x)
    $('#y').html round(a.y)
    $('#z').html round(a.z)

  onCompass = (a) ->
    $('#h').html a.magneticHeading

  onError = (error) ->
    alert "Error (#{error.name}: #{error.message})"

  accelerometer = undefined
  $('#toggle-accel').on 'tap', (e) ->
    if accelerometer?
      accelerometer = navigator.accelerometer.clearWatch accelerometer
      onAccelerometer x: 'Off', y: 'Off', z: 'Off'
    else
      accelerometer = navigator.accelerometer.watchAcceleration(
        onAccelerometer,
        onError,
        frequency: 250
      )
    e.preventDefault()

  compass = undefined
  $('#toggle-compass').on 'tap', (e) ->
    if compass?
      compass = navigator.compass.clearWatch compass
      onCompass magneticHeading: 'Off'
    else
      compass = navigator.compass.watchHeading(
        onCompass,
        onError,
        frequency: 250
      )
    e.preventDefault()

  $('#vibrate').on 'tap', (e) ->
    navigator.notification.vibrate(0)
    e.preventDefault()
