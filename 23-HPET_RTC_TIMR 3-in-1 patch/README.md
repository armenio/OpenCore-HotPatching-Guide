## HPET_RTC_TIMR 3-in-1 patch

#### Description

- Parts of the sound card of the earlier machine **HPET** [PNP0103] Provide interrupt numbers 0 and 8, otherwise the sound card will not work properly. In fact, **HPET** for almost all machines did not provide any interrupt numbers. Under normal circumstances, interrupt numbers 0 and 8 are occupied by **RTC** [PNP0B00] and **TIMR** [PNP0100], respectively.
- Simultaneously fix the above problems **HPET**, **RTC**, **TIMR**.

#### Patch principle

- Disable the three components **HPET**, **RTC**, **TIMR**.
- Counterfeit three parts, namely: **HPE0**, **RTC0**, **TIM0**.
- Removed `IRQNoFlags () {8}` of **RTC0** and `IRQNoFlags () {0}` of **TIM0** and added them to **HPE0**.

#### Patch method

- Disable **HPET**、**RTC**、**TIMR** 
  - **HPET** 
  
    HPET usually has `_STA`, so to disable HPET, you need to use the Preset Variable Method. Such as:
  
```
        External (HPAE, IntObj)
        //External (HPTE, IntObj)
        Scope (\)
        {
            If (_OSI ("Darwin"))
            {
                HPAE =0
                //HPTE =0
            }
        }
```
  
    Note: The `HPAE` variable randomizer in` _STA` may be different。
  
  - **RTC**  
  
    The RTC of earlier machines does not have `_STA`. Press the Method (_STA,` method to disable RTC. For example:
  
```
    		Method (_STA, 0, NotSerialized)
    		{
    				If (_OSI ("Darwin"))
    				{
    						Return (0)
    				}
    				Else
    				{
    						Return (0x0F)
    				}
    		}
```
  
- **TIMR**
  
     Same as **RTC**.
  
- Patch file: ***SSDT-HPET_RTC_TIMR-fix***

   See **Patch Principle** above for reference examples.

#### Precautions

- This patch cannot be used with the following patches:
   - ***SSDT-RTC_Y-AWAC_N*** of the "Preset Variable Method"
   - OC official ***SSDT-AWAC***
   - "Counterfeit Device" or OC official ***SSDT-RTC0***
   - ***SSDT-RTC0-NoFlags for CMOS Reset Patch***
- `LPCB` name, **three parts** name should be the same as the original ACPI part name.

