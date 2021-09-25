def gpioState():
    import RPi.GPIO as GPIO

    GPIO.setmode(GPIO.BOARD)

    GPIO.setup(8,GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.setup(10,GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.setup(12,GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.setup(16,GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

    output = ""

    if(GPIO.input(8) == 1):
        output = output + "1"
    else:
        output = output + "0"
    if(GPIO.input(10) == 1):
        output = output + "1"
    else:
        output = output + "0"
    if(GPIO.input(12) == 1):
        output = output + "1"
    else:
        output = output + "0"
    if(GPIO.input(16) == 1):
        output = output + "1"
    else:
        output = output + "0"
    return output

print(gpioState())