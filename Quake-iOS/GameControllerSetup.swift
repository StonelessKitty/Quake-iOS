//
//  GameControllerSetup.swift
//  Quake-iOS
//
//  Created by Heriberto Delgado on 7/8/16.
//
//  Edited by Elise Gibson-Baker on 06/06/19.
//
//

import GameController

public var remote: GCController? = nil

public var currentViewController: UIViewController? = nil

public var strafe = false

public var alwaysRun = false

class GameControllerSetup: NSObject
{
    static func connect(_ controller: GCController?)
    {
        for controller in GCController.controllers()
        {
            if controller.extendedGamepad != nil && remote == nil
            {
                remote = controller
                
                remote!.playerIndex = .index1
                
                remote!.controllerPausedHandler = { (controller: GCController) -> () in
                    
                    Sys_Key_Event(27, qboolean(1)) // K_ESCAPE, true
                    Sys_Key_Event(27, qboolean(0)) // K_ESCAPE, false
                    
                }
                
                remote!.extendedGamepad!.dpad.up.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(128, qboolean(pressed ? 1 : 0)) // K_UPARROW, true / false
                }
                
                
                remote!.extendedGamepad!.dpad.left.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(130, qboolean(pressed ? 1 : 0)) // K_LEFTARROW, true / false
                    
                }
                
                remote!.extendedGamepad!.dpad.right.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(131, qboolean(pressed ? 1 : 0)) // K_RIGHTARROW, true / false
                    
                }
                
                remote!.extendedGamepad!.dpad.down.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(129, qboolean(pressed ? 1 : 0)) // K_DOWNARROW, true / false
                    
                }
                
                remote!.extendedGamepad!.buttonA.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(32, qboolean(pressed ? 1 : 0)) // K_ENTER, true / false
                    
                }
                
                remote!.extendedGamepad!.buttonB.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    //                    Sys_Key_Event(27, qboolean(pressed ? 1 : 0)) // K_ESCAPE, true / false
                    
                }
                
                remote!.extendedGamepad!.buttonY.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                }
                
                remote!.extendedGamepad!.leftThumbstick.xAxis.valueChangedHandler = { (button: GCControllerAxisInput, value: Float) -> () in
                    
                    in_forwardmove = value
                    
                }
                
                remote!.extendedGamepad!.leftThumbstick.yAxis.valueChangedHandler = { (button: GCControllerAxisInput, value: Float) -> () in
                    
                    in_sidestepmove = value
                    
                }
                
                remote!.extendedGamepad!.rightThumbstick.xAxis.valueChangedHandler = { (button: GCControllerAxisInput, value: Float) -> () in
                    
                    in_rollangle = value
                    
                }
                
                remote!.extendedGamepad!.rightThumbstick.yAxis.valueChangedHandler = { (button: GCControllerAxisInput, value: Float) -> () in
                    
                    in_pitchangle = -value
                    
                }
                
                remote!.extendedGamepad!.rightTrigger.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(133, qboolean(pressed ? 1 : 0)) // K_CTRL, true / false
                    
                }
                
                remote!.extendedGamepad!.rightShoulder.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    if pressed
                    {
                        Sys_Cbuf_AddText("impulse 10\n")
                    }
                    
                }
                
                break
            } else if controller.gamepad != nil && remote == nil
            {
                remote = controller
                
                remote!.playerIndex = .index1
                
                remote!.controllerPausedHandler = { (controller: GCController) -> () in
                    
                    Sys_Key_Event(27, qboolean(1)) // K_ESCAPE, true
                    Sys_Key_Event(27, qboolean(0)) // K_ESCAPE, false
                    
                }
                
                remote!.gamepad!.buttonA.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    Sys_Key_Event(32, qboolean(pressed ? 1 : 0))
                    print("Pressed A")
                    
                }
                
                remote!.gamepad!.buttonB.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    //Sys_Key_Event(132, qboolean(pressed ? 1 : 0))
                    if pressed && alwaysRun == false
                    {
                        print("B run", alwaysRun)
                        Sys_Cbuf_AddText("+speed\n")
                        Cbuf_Execute()
                        alwaysRun = true
                    } else if pressed && alwaysRun == true
                    {
                        print("B run", alwaysRun)
                        Sys_Cbuf_AddText("-speed\n")
                        Cbuf_Execute()
                        alwaysRun = false
                    }
                    print("Pressed B")
                }
                
                remote!.gamepad!.buttonY.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    Sys_Key_Event(47, qboolean(pressed ? 1 : 0))
                    print("Pressed Y")
                }
                
                remote!.gamepad!.dpad.up.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(128, qboolean(pressed ? 1 : 0)) // K_UPARROW, true / false
                    print("Pressed DPad_Up")
                }
                
                
                remote!.gamepad!.dpad.left.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(130, qboolean(pressed ? 1 : 0)) // K_LEFTARROW, true / false
                    print("Pressed DPad_Left")
                }
                
                remote!.gamepad!.dpad.right.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(131, qboolean(pressed ? 1 : 0)) // K_RIGHTARROW, true / false
                    print("Pressed DPad_Right")
                }
                
                remote!.gamepad!.dpad.down.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    
                    Sys_Key_Event(129, qboolean(pressed ? 1 : 0)) // K_DOWNARROW, true / false
                    print("Pressed DPad_Down")
                }
                
                remote!.gamepad!.rightShoulder.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    Sys_Key_Event(133, qboolean(pressed ? 1 : 0))
                    print("Pressed Right_Shoulder")
                }
                
                remote!.gamepad!.leftShoulder.pressedChangedHandler = { (button: GCControllerButtonInput, value: Float, pressed: Bool) -> () in
                    if pressed && strafe == false
                    {
                        print("leftshoulder strafe", strafe)
                        Sys_Cbuf_AddText("+strafe\n")
                        Cbuf_Execute()
                        strafe = true
                    } else if pressed && strafe == true
                    {
                        print("leftshoulder strafe", strafe)
                        Sys_Cbuf_AddText("-strafe\n")
                        Cbuf_Execute()
                        strafe = false
                    }
                }
            }
            break
        }
    }
    
    static func disconnect(_ controller: GCController?)
    {
        if remote == controller
        {
            in_forwardmove = 0.0
            in_sidestepmove = 0.0
            in_rollangle = 0.0
            in_pitchangle = 0.0
            
            remote = nil
        }
    }
}
