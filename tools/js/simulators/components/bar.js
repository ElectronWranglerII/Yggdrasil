/*
System Emulation Component: Block Address Register
Copyright (C) DeRemee Systems, IXE Electronics LLC
Portions copyright IXE Electronics LLC, Republic Robotics,
FemtoLaunch, FemtoSat, FemtoTrack, Weland
This work is made available under the Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit
http://creativecommons.org/licenses/by-nc-sa/4.0/.
*/
class BlockAddressRegister{
    constructor(){
        this._Page = 0;
        this._Port = 0;
        this._RAMReadDisable = 0;
        this._ROMWriteDisable = 0;
    }
    Page(){
        return this._Page;
    }
    Port(Value){
        this._Port = Value;
    }
    RAMRDIS(){
        return this._RAMReadDisable;
    }
    Read(){
        return	this._ROMWriteDisable << 7 +
                this._RAMReadDisable << 6 +
                this._Page;
    }
    Reset(){
        this._Page = 0;
        this._RAMReadDisable = 0;
        this._ROMWriteDisable = 0;
    }
    ROMWDIS(){
        return this._ROMWriteDisable;
    }
    Write(Value){
        this._Page = (Value & 63) >>> 0;
        this._RAMReadDisable = (Value & 64) >>> 0;
        this._ROMWriteDisable = (Value & 128) >>> 0;
    }
}
