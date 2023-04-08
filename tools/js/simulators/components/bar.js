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
