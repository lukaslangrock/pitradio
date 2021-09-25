using System;
using RaspberryPiDotNet;

namespace Gpio
{
    class Program
    {
        static void Main(string[] args)
        {
            // GPIO's initialisieren
            GPIOMem mDown = new GPIOMem(GPIOPins.V2_GPIO_8);
            GPIOMem next = new GPIOMem(GPIOPins.V2_GPIO_10);
            GPIOMem play = new GPIOMem(GPIOPins.V2_GPIO_12);
            GPIOMem back = new GPIOMem(GPIOPins.V2_GPIO_16);

            while (true)
            {
                
                // GPIO lesen
                if (mDown.Read() == true)
                {
                    Console.WriteLine("mDown")
                }
                if (next.Read() == true)
                {
                    Console.WriteLine("next")
                }
                if (play.Read() == true)
                {
                    Console.WriteLine("play")
                }
                if (back.Read() == true)
                {
                    Console.WriteLine("back")
                }
            }
        }
    }
}