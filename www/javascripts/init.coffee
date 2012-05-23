
window.init = ($) ->
  $('#version').html $version$
  
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

  accelerometer = undefined
  compass = undefined

  onAccelerometer = (a) ->
    $('#x').html round(a.x)
    $('#y').html round(a.y)
    $('#z').html round(a.z)
  onAccelerometerError = (error) ->
    alert "Accelerometer error (#{error.name}: #{error.message})"
    accelerometer = navigator.accelerometer.clearWatch accelerometer

  onCompass = (a) ->
    $('#h').html a.magneticHeading
  onCompassError = (error) ->
    alert "Error (#{error.name}: #{error.message})"
    compass = navigator.compass.clearWatch compass

  $('#toggle-accel').on 'tap', (e) ->
    if accelerometer?
      accelerometer = navigator.accelerometer.clearWatch accelerometer
      onAccelerometer x: 'Off', y: 'Off', z: 'Off'
    else
      accelerometer = navigator.accelerometer.watchAcceleration(
        onAccelerometer,
        onAccelerometerError,
        frequency: 250
      )
    e.preventDefault()
    $('#toggle-accel').one 'click', (e) ->
      e.preventDefault()
      
  $('#toggle-compass').on 'tap', (e) ->
    if compass?
      compass = navigator.compass.clearWatch compass
      onCompass magneticHeading: 'Off'
    else
      compass = navigator.compass.watchHeading(
        onCompass,
        onCompassError,
        frequency: 250
      )
    e.preventDefault()
    $('#toggle-compass').one 'click', (e) ->
      e.preventDefault()
      
  $('#vibrate').on 'tap', (e) ->
    navigator.notification.vibrate(0)
    e.preventDefault()
    $('#vibrate').one 'click', (e) ->
      e.preventDefault()