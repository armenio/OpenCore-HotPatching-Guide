//
DefinitionBlock("", "SSDT", 2, "hack", "PNLF", 0)
{
    Scope(_SB)
    {
        Device(PNLF)
        {
            Name(_ADR, Zero)
            Name(_HID, EisaId ("APP0002"))
            Name(_CID, "backlight")
            //Skylake/KabyLake/KabyLake-R
            Name(_UID, 16)
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }        
    }
}
//EOF