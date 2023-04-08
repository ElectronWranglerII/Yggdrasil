/*
System Emulation Component: Generic LCD
Copyright (C) DeRemee Systems, IXE Electronics LLC
Portions copyright IXE Electronics LLC, Republic Robotics,
FemtoLaunch, FemtoSat, FemtoTrack, Weland
This work is made available under the Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit
http://creativecommons.org/licenses/by-nc-sa/4.0/.
*/
class GenericLCDCommand{
    constructor(){
        this._ReadAddress = 0;
        this._ReadAddressByte = 0;
        this._ReadAddressH = 0;
        this._ReadAddressL = 0;
        this._WriteAddress = 0;
        this._WriteAddressByte = 0;
        this._WriteAddressH = 0;
        this._WriteAddressL = 0;
        this._DataObject = "";
        this._Mode = 0;
    }
    DataPort(Obj){
        this._DataObject = Obj;
    }
    Read(){
    
    }
    Reset(){
        this._ReadAddress = 0;
        this._ReadAddressByte = 0;
        this._ReadAddressH = 0;
        this._ReadAddressL = 0;
        this._WriteAddress = 0;
        this._WriteAddressByte = 0;
        this._WriteAddressH = 0;
        this._WriteAddressL = 0;
        this._Mode = 0;
    }
    Write(Command){
        switch(this._Mode){
            //Command
            case 0:
                switch((Command & 255) >>> 0){
                    //NOP
                    case 0:
                        break;
                    //Reset
                    case 1:
                        this.Reset();
                        break;
                    //Set Write Address
                    case 2:
                        this._Mode = 2;
                        break;
                    //Set Read Address
                    case 3:
                        this._Mode = 3;
                        break;
                    default:
                        break;
                }
                break;
            //Set WriteAddress
            case 2:
                if(this._WriteAddressByte == 0){
                    this._WriteAddressL = Command;
                    this._WriteAddressByte = 1;
                }else{
                    this._WriteAddressH = Command;
                    this._WriteAddress = this._WriteAddressH * 256 + this._WriteAddressL;
                    this._DataObject.WriteAddress(this._WriteAddress);
                    this._WriteAddressByte = 0;
                    this._Mode = 0;
                }
                break;
            //Set ReadAddress
            case 3:
                if(this._ReadAddressByte == 0){
                    this._ReadAddressL = Command;
                    this._ReadAddressByte = 1;
                }else{
                    this._ReadAddressH = Command;
                    this._ReadAddress = this._ReadAddressH * 256 + this._ReadAddressL;
                    this._DataObject.ReadAddress(this._ReadAddress);
                    this._ReadAddressByte = 0;
                }
                this._Mode = 0;
                break;
            default:
                break;
        }
    }
}

class GenericLCDData{
    constructor(){
        this._ReadAddress = 0;
        this._Refresh = true;
        this._WriteAddress = 0;
        this._Data = Array(2048).fill(0);
        this._DisplayPage = 0;
        this._DisplayArea = document.getElementById("LCDCanvas").getContext("2d");
    }
    DisplayPage(Page){
        this._DisplayPage = (Page & 1) >>> 0;
    }
    Draw(){
        this._DisplayArea.fillStyle = "#A0C0B0";
        this._DisplayArea.fillRect(0, 0, this._DisplayArea.canvas.width, this._DisplayArea.canvas.height);
        let AddressHigh = this._DisplayPage * 2048;
        let Column = 0;
        let Row = 0;
        let Bit = 1;
        for(let i = 0; i < 1024; i++){
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = Bit << 1;
            Row = Row + 1;
            this.DrawPixel(Column, Row, this._Data[AddressHigh + i] & Bit);
            Bit = 1;
            Row = Row + 1;
            if(Row > 63){
                Row = 0;
                Column = Column + 1;
            }
        }
    }
    DrawPixel(Column, Row, Value){
        if(Value == 0){
            this._DisplayArea.fillStyle = "#A0C0B0";
        }else{
            this._DisplayArea.fillStyle = "#304040";
        }
        this._DisplayArea.fillRect(Column * 2, Row * 2, 2, 2);
    }
    Read(){
        let Temp = this._ReadAddress;
        this._ReadAddress = ReadAddress + 1;
        if((this._ReadAddress & 2048) - (Temp & 2048) != 0){
            this._ReadAddress = Temp & 2048;
        }
        return this._Data[Temp];
    }
    ReadAddress(Address){
        this._ReadAddress = (Address & 2047) >>> 0;
    }
    Reset(){
        this._Data = Array(2048).fill(0);
        this._DisplayPage = 0;
        this._ReadAddress = 0;
        this._WriteAddress = 0;
    }
    Write(Value){
        this._Refresh = true;
        this._Data[this._WriteAddress] = Value;
        let Temp = this._WriteAddress;
        this._WriteAddress = this._WriteAddress + 1;
        if((this._WriteAddress & 2048) - (Temp & 2048) != 0){
            this._WriteAddress = Temp & 2048;
        }
    }
    WriteAddress(Address){
        this._WriteAddress = (Address & 2047) >>> 0;
    }
}
