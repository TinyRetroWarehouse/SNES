// SNES SPC700 FFVII Prelude Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "FFVIIPrelude.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

constant MaxQuant(180) // Maximum Quantization ms

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($B800,$48) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$B8)  // Echo Source Address
  WDSP(DSP_EDL,9)    // Echo Delay
  WDSP(DSP_EON,%11111111) // Echo On Flags
  WDSP(DSP_FLG,0)    // Enable Echo Buffer Writes
  WDSP(DSP_EFB,70)   // Echo Feedback
  WDSP(DSP_FIR0,127) // Echo FIR Filter Coefficient 0
  WDSP(DSP_FIR1,0)   // Echo FIR Filter Coefficient 1
  WDSP(DSP_FIR2,0)   // Echo FIR Filter Coefficient 2
  WDSP(DSP_FIR3,0)   // Echo FIR Filter Coefficient 3
  WDSP(DSP_FIR4,0)   // Echo FIR Filter Coefficient 4
  WDSP(DSP_FIR5,0)   // Echo FIR Filter Coefficient 5
  WDSP(DSP_FIR6,0)   // Echo FIR Filter Coefficient 6
  WDSP(DSP_FIR7,0)   // Echo FIR Filter Coefficient 7
  WDSP(DSP_EVOLL,25) // Echo Volume Left
  WDSP(DSP_EVOLR,25) // Echo Volume Right

  WDSP(DSP_V0VOLL,25)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,25)   // Voice 0: Volume Right
  WDSP(DSP_V0SRCN,0)    // Voice 0: Synth Harp
  WDSP(DSP_V0ADSR1,$FB) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$F6) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)  // Voice 0: Gain

  WDSP(DSP_V1VOLL,25)   // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,25)   // Voice 1: Volume Right
  WDSP(DSP_V1SRCN,1)    // Voice 1: Flute
  WDSP(DSP_V1ADSR1,$FF) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$E0) // Voice 1: ADSR2
  WDSP(DSP_V1GAIN,127)  // Voice 1: Gain

  WDSP(DSP_V2VOLL,25)   // Voice 2: Volume Left
  WDSP(DSP_V2VOLR,25)   // Voice 2: Volume Right
  WDSP(DSP_V2SRCN,2)    // Voice 2: Oboe
  WDSP(DSP_V2ADSR1,$FF) // Voice 2: ADSR1
  WDSP(DSP_V2ADSR2,$E0) // Voice 2: ADSR2
  WDSP(DSP_V2GAIN,127)  // Voice 2: Gain

  WDSP(DSP_V3VOLL,25)   // Voice 3: Volume Left
  WDSP(DSP_V3VOLR,25)   // Voice 3: Volume Right
  WDSP(DSP_V3SRCN,3)    // Voice 3: Clarinet
  WDSP(DSP_V3ADSR1,$FF) // Voice 3: ADSR1
  WDSP(DSP_V3ADSR2,$E0) // Voice 3: ADSR2
  WDSP(DSP_V3GAIN,127)  // Voice 3: Gain

  WDSP(DSP_V4VOLL,25)   // Voice 4: Volume Left
  WDSP(DSP_V4VOLR,25)   // Voice 4: Volume Right
  WDSP(DSP_V4SRCN,4)    // Voice 4: Bassoon
  WDSP(DSP_V4ADSR1,$FF) // Voice 4: ADSR1
  WDSP(DSP_V4ADSR2,$E0) // Voice 4: ADSR2
  WDSP(DSP_V4GAIN,127)  // Voice 4: Gain

  WDSP(DSP_V5VOLL,25)   // Voice 5: Volume Left
  WDSP(DSP_V5VOLR,25)   // Voice 5: Volume Right
  WDSP(DSP_V5SRCN,5)    // Voice 5: French Horn
  WDSP(DSP_V5ADSR1,$FF) // Voice 5: ADSR1
  WDSP(DSP_V5ADSR2,$E0) // Voice 5: ADSR2
  WDSP(DSP_V5GAIN,127)  // Voice 5: Gain

  WDSP(DSP_V6VOLL,25)   // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,25)   // Voice 6: Volume Right
  WDSP(DSP_V6SRCN,6)    // Voice 6: Strings
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$E0) // Voice 6: ADSR2
  WDSP(DSP_V6GAIN,127)  // Voice 6: Gain

  WDSP(DSP_V7VOLL,25)   // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,25)   // Voice 7: Volume Right
  WDSP(DSP_V7SRCN,6)    // Voice 7: Strings
  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2
  WDSP(DSP_V7GAIN,127)  // Voice 7: Gain

// Setup Zero Page RAM
constant PATTERN($00) // Pattern Zero Page RAM Address
constant PATTERNOFS($02) // Pattern Offset Zero Page RAM Address

StartSong:
  lda #PATTERNLIST    // A = Pattern List (LSB)
  ldy #PATTERNLIST>>8 // Y = Pattern List (MSB)
  stw PATTERNOFS      // Store YA To Zero Page RAM

  ldy #0 // Y = 0 (Pattern Offset Index)

LoopSong:


  // Channel 1 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #0 // Y = 0
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF1 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND1 // IF (A == SUST) GOTO Key End
  bra KEYON1  // ELSE GOTO Channel 1: Key On

  KEYOFF1: // Key Off
    WDSP(DSP_KOFF,%00000001) // DSP Register Data = Key Off Flags
    bra KEYEND1 // GOTO Key End

  KEYON1: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V0PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w SynthHarpPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V0PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w SynthHarpPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00000001)  // DSP Register Data = Key On Flags
  KEYEND1: // Key End


  // Channel 2 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #2 // Y = 2
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF2 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND2 // IF (A == SUST) GOTO Key End
  bra KEYON2  // ELSE GOTO Channel 1: Key On

  KEYOFF2: // Key Off
    WDSP(DSP_KOFF,%00000010) // DSP Register Data = Key Off Flags
    bra KEYEND2 // GOTO Key End

  KEYON2: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V1PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w FlutePitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V1PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w FlutePitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00000010)  // DSP Register Data = Key On Flags
  KEYEND2: // Key End


  // Channel 3 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #4 // Y = 4
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF3 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND3 // IF (A == SUST) GOTO Key End
  bra KEYON3  // ELSE GOTO Channel 1: Key On

  KEYOFF3: // Key Off
    WDSP(DSP_KOFF,%00000100) // DSP Register Data = Key Off Flags
    bra KEYEND3 // GOTO Key End

  KEYON3: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V2PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w OboePitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V2PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w OboePitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00000100)  // DSP Register Data = Key On Flags
  KEYEND3: // Key End


  // Channel 4 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #6 // Y = 6
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF4 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND4 // IF (A == SUST) GOTO Key End
  bra KEYON4  // ELSE GOTO Channel 1: Key On

  KEYOFF4: // Key Off
    WDSP(DSP_KOFF,%00001000) // DSP Register Data = Key Off Flags
    bra KEYEND4 // GOTO Key End

  KEYON4: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V3PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w ClarinetPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V3PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w ClarinetPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00001000)  // DSP Register Data = Key On Flags
  KEYEND4: // Key End


  // Channel 5 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #8 // Y = 8
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF5 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND5 // IF (A == SUST) GOTO Key End
  bra KEYON5  // ELSE GOTO Channel 1: Key On

  KEYOFF5: // Key Off
    WDSP(DSP_KOFF,%00010000) // DSP Register Data = Key Off Flags
    bra KEYEND5 // GOTO Key End

  KEYON5: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V4PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w BassoonPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V4PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w BassoonPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00010000)  // DSP Register Data = Key On Flags
  KEYEND5: // Key End


  // Channel 6 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #10 // Y = 10
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF6 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND6 // IF (A == SUST) GOTO Key End
  bra KEYON6  // ELSE GOTO Channel 1: Key On

  KEYOFF6: // Key Off
    WDSP(DSP_KOFF,%00100000) // DSP Register Data = Key Off Flags
    bra KEYEND6 // GOTO Key End

  KEYON6: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V5PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w FrenchHornPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V5PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w FrenchHornPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%00100000)  // DSP Register Data = Key On Flags
  KEYEND6: // Key End


  // Channel 7 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #12 // Y = 12
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF7 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND7 // IF (A == SUST) GOTO Key End
  bra KEYON7  // ELSE GOTO Channel 1: Key On

  KEYOFF7: // Key Off
    WDSP(DSP_KOFF,%01000000) // DSP Register Data = Key Off Flags
    bra KEYEND7 // GOTO Key End

  KEYON7: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V6PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w StringsPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V6PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w StringsPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%01000000)  // DSP Register Data = Key On Flags
  KEYEND7: // Key End


  // Channel 8 Pattern
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #14 // Y = 14
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST   // Compare A To REST Byte ($FE)
  beq KEYOFF8 // IF (A == REST) GOTO Key Off
  cmp #SUST   // Compare A To SUST Byte ($FD)
  beq KEYEND8 // IF (A == SUST) GOTO Key End
  bra KEYON8  // ELSE GOTO Channel 1: Key On

  KEYOFF8: // Key Off
    WDSP(DSP_KOFF,%10000000) // DSP Register Data = Key Off Flags
    bra KEYEND8 // GOTO Key End

  KEYON8: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V7PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w StringsPitchTable,x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V7PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w StringsPitchTable,x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,%10000000)  // DSP Register Data = Key On Flags
  KEYEND8: // Key End


  // Wait For MilliSecond Amount (8kHz Timer)
  lda #MaxQuant // Granularity = 1ms, Max Wait = 256ms
  str REG_T0DIV=#8 // 8kHz Clock Divider 8 = 1024 Clock Ticks (1ms)
  str REG_CONTROL=#$01
  WaitMS:
    bbc REG_T0OUT:0=WaitMS // IF (REG_T0OUT.BIT0 == 0) Wait For Timer
    dec // A--
    bne WaitMS // IF (A != 0) Loop Timer Wait

  iny // Increment Song Offset
  bne PatternEnd // IF (Y != 0) Pattern End, ELSE Pattern Increment

  // Channel 1..8 Pattern Increment
  lda #16 // YA = 16
  adw PATTERNOFS // YA += Pattern Offset
  stw PATTERNOFS // Pattern Offset = YA

  // Compare Pattern List End Address
  lda #PATTERNLISTEND    // A = Pattern List End (LSB)
  ldy #PATTERNLISTEND>>8 // Y = Pattern List End (MSB)
  cpw PATTERNOFS         // Compare YA To Zero Page RAM
  bne PatternIncEnd      // IF (Pattern Offset != Pattern List End Offset) Pattern Increment End, ELSE Set Pattern Loop Offset

  // Set Pattern Loop Offset
  lda #PATTERNLISTLOOP    // A = Pattern List Loop (LSB)
  ldy #PATTERNLISTLOOP>>8 // Y = Pattern List Loop (MSB)
  stw PATTERNOFS          // Store YA To Zero Page RAM

  PatternIncEnd:
    ldy #0 // Y = 0

  PatternEnd:
    jmp LoopSong // GOTO Loop Song

SynthHarpPitchTable:
  WritePitchTable($EC80) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
FlutePitchTable:
  WritePitchTable($EC80) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
OboePitchTable:
  WritePitchTable($EC80) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
ClarinetPitchTable:
  WritePitchTable($D080) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
BassoonPitchTable:
  WritePitchTable($B080) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
FrenchHornPitchTable:
  WritePitchTable($FE80) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
StringsPitchTable:
  WritePitchTable($F880) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)

PATTERN00: // Pattern 00: Rest (Channel 2..8)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 1
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 2
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 3
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 4
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 5
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 6
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 7
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 8
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 9
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 10
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 11
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 12
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 13
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 14
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 15
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 16

PATTERN01: // Pattern 01: Synth Harp (Channel 1)
  db  C2, D2,  E2, G2,  C3, D3,  E3, G3,  C4, D4,  E4, G4,  C5, D5,  E5, G5 // 1
  db  C6, G5,  E5, D5,  C5, G4,  E4, D4,  C4, G3,  E3, D3,  C3, G2,  E2, D2 // 2
  db  A1, B1,  C2, E2,  A2, B2,  C3, E3,  A3, B3,  C4, E4,  A4, B4,  C5, E5 // 3
  db  A5, E5,  C5, B4,  A4, E4,  C4, B3,  A3, E3,  C3, B2,  A2, E2,  C2, B1 // 4
  db  C2, D2,  E2, G2,  C3, D3,  E3, G3,  C4, D4,  E4, G4,  C5, D5,  E5, G5 // 5
  db  C6, G5,  E5, D5,  C5, G4,  E4, D4,  C4, G3,  E3, D3,  C3, G2,  E2, D2 // 6
  db  A1, B1,  C2, E2,  A2, B2,  C3, E3,  A3, B3,  C4, E4,  A4, B4,  C5, E5 // 7
  db  A5, E5,  C5, B4,  A4, E4,  C4, B3,  A3, E3,  C3, B2,  A2, E2,  C2, B1 // 8
  db  A1, C2,  F2, G2,  A2, C3,  F3, G3,  A3, C4,  F4, G4,  A4, C5,  F5, G5 // 9
  db  A5, G5,  F5, C5,  A4, G4,  F4, C4,  A3, G3,  F3, C3,  A2, G2,  F2, C2 // 10
  db  B1, D2,  G2, A2,  B2, D3,  G3, A3,  B3, D4,  G4, A4,  B4, D5,  G5, A5 // 11
  db  B5, A5,  G5, D5,  B4, A4,  G4, D4,  B3, A3,  G3, D3,  B2, A2,  G2, D2 // 12
  db G1s, C2, E2b, G2, G2s, C3, E3b, G3, G3s, C4, E4b, G4, G4s, C5, E5b, G5 // 13
  db G5s, G5, E5b, C5, G4s, G4, E4b, C4, G3s, G3, E3b, C3, G2s, G2, E2b, C2 // 14
  db B1b, D2,  F2, A2, B2b, D3,  F3, A3, B3b, D4,  F4, A4, B4b, D5,  F5, A5 // 15
  db B5b, A5,  F5, D5, B4b, A4,  F4, D4, B3b, A3,  F3, D3, B2b, A2,  F2, D2 // 16

PATTERN02: // Pattern 02: Flute (Channel 2)
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 17
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 18
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 19
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 21
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db   F4, SUST,   G4, SUST,   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 23
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 24
  db   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 25
  db   B3, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   E4, SUST, SUST, REST // 27
  db   F4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db   D4, SUST, SUST, SUST,   C4, SUST, B3b, SUST,   G3s, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 29
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 30
  db  E4b, SUST, SUST, SUST,   D4, SUST,   C4, SUST,  B3b, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN03: // Pattern 03: Flute (Channel 2)
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 33
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 37
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   F4, SUST,   G4, SUST,   E4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   F4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 41
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 43
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db   F4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN04: // Pattern 04: Oboe (Channel 3)
  db   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 17
  db   B3, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 18
  db   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 19
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 21
  db   B3, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db   D4, SUST,   E4, SUST,   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 23
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 24
  db   A3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 25
  db   G3, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A3, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   B3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C4, SUST, SUST, REST // 27
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   G4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db   F4, SUST, SUST, SUST,  E4b, SUST,   D4, SUST,   C4, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 29
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 30
  db   G4, SUST, SUST, SUST,   F4, SUST,  E4b, SUST,   D4, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN05: // Pattern 05: Oboe (Channel 3)
  db   G3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 33
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   A3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   G3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 37
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   A3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   A3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 41
  db   G3, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A3, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   B3, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C4, SUST, SUST, REST // 43
  db   D4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   B3, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db  G3s, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db  B3b, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN06: // Pattern 06: Clarinet (Channel 4)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 17
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 18
  db   A5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 19
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 21
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 23
  db   C5, SUST, SUST, REST,   D5, SUST, SUST, REST,   E5, SUST, SUST, REST,   G5, SUST, SUST, REST // 24
  db   A5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 25
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 27
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 29
  db   C5, SUST, SUST, REST,   D5, SUST, SUST, REST,  E5b, SUST, SUST, REST,   F5, SUST, SUST, REST // 30
  db   G5, SUST, SUST, REST,   F5, SUST,  E5b, SUST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN07: // Pattern 07: Clarinet (Channel 4)
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 33
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 37
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 37
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   D5, SUST,   E5, SUST,   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 41
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   E5, SUST, SUST, REST // 43
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN08: // Pattern 08: Bassoon (Channel 5)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 17
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 18
  db   C7, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 19
  db   B6, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A6, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   E7, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 21
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 23
  db   A6, SUST, SUST, REST,   B6, SUST, SUST, REST,   C7, SUST, SUST, REST,   E7, SUST, SUST, REST // 24
  db   F7, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 25
  db   E7, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D7, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   B6, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C7, SUST, SUST, REST // 27
  db   D7, SUST, SUST, SUST, SUST, SUST, SUST, REST,   B6, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 29
  db  G6s, SUST, SUST, REST,  B6b, SUST, SUST, REST,   C7, SUST, SUST, REST,   D7, SUST, SUST, REST // 30
  db  E7b, SUST, SUST, REST,   D7, SUST,   C7, SUST,  B6b, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN09: // Pattern 09: Bassoon (Channel 5)
  db   C6, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 33
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   A5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   C6, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 37
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   A5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 41
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 43
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db  G5s, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db  B5b, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN10: // Pattern 10: FrenchHorn (Channel 6)
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 33
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 37
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   D5, SUST,   E5, SUST,   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 41
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C5, SUST, SUST, REST // 43
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   G5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db   F5, SUST, SUST, REST,  E5b, SUST,   D5, SUST,   C5, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db   G5, SUST, SUST, REST,   F5, SUST,  E5b, SUST,   D5, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,  B4b, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN11: // Pattern 11: Strings (Channel 7)
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 17
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 18
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 19
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 21
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db   F5, SUST,   G5, SUST,   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 23
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 24
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 25
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 27
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 29
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 30
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN12: // Pattern 12: Strings (Channel 7)
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 33
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 37
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   F5, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   F5, SUST,   G5, SUST,   E5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 41
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 43
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db   F5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db   G5, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERN13: // Pattern 13: Strings (Channel 8)
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 17
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 18
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 19
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 20
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 21
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 22
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 23
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 24
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 25
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 26
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C5, SUST, SUST, REST // 27
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 28
  db  G4s, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 29
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 30
  db  B4b, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 31
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 32
PATTERN14: // Pattern 14: Strings (Channel 8)
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 33
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 34
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 35
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 36
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 37
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 38
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 39
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 40
  db   A4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 41
  db   G4, SUST, SUST, SUST, SUST, SUST, SUST, REST,   A4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 42
  db   B4, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST,   C5, SUST, SUST, REST // 43
  db   D5, SUST, SUST, SUST, SUST, SUST, SUST, REST,   B4, SUST, SUST, SUST, SUST, SUST, SUST, REST // 44
  db  G4s, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 45
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 46
  db  B4b, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 47
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, REST // 48

PATTERNLIST:
  dw PATTERN01,PATTERN00,PATTERN00,PATTERN00,PATTERN00,PATTERN00,PATTERN00,PATTERN00 // Channel 1..8 Pattern Address List
PATTERNLISTLOOP:
  dw PATTERN01,PATTERN02,PATTERN04,PATTERN06,PATTERN08,PATTERN00,PATTERN11,PATTERN13 // Channel 1..8 Pattern Address List
  dw PATTERN01,PATTERN03,PATTERN05,PATTERN07,PATTERN09,PATTERN10,PATTERN12,PATTERN14 // Channel 1..8 Pattern Address List
PATTERNLISTEND:

seek($3000); sampleDIR:
  dw SynthHarp, SynthHarp + 9      // 0
  dw Flute, Flute + 2322           // 1
  dw Oboe, Oboe + 4770             // 2
  dw Clarinet, Clarinet + 3852     // 3
  dw Bassoon, Bassoon + 3015       // 4
  dw FrenchHorn, FrenchHorn + 5301 // 5
  dw Strings, Strings + 5616       // 6

seek($3100) // Sample Data
  insert SynthHarp, "BRR/001. Synth Harp (Loop=9,AD=$FB,SR=$F6,Echo)(C9Freq=$EC80).brr"
  insert Flute, "BRR/006. Flute (Loop=2322,AD=$FF,SR=$E0,Echo)(C9Freq=$EC80).brr"
  insert Oboe, "BRR/002. Oboe (Loop=4770,AD=$FF,SR=$E0,Echo)(C9Freq=$EC80).brr"
  insert Clarinet, "BRR/007. Clarinet (Loop=3852,AD=$FF,SR=$E0,Echo)(C9Freq=$D080).brr"
  insert Bassoon, "BRR/003. Bassoon (Loop=3015,AD=$FF,SR=$E0,Echo)(C9Freq=$B080).brr"
  insert FrenchHorn, "BRR/004. French Horn (Loop=5301,AD=$FF,SR=$E0,Echo)(C9Freq=$FE80).brr"
  insert Strings, "BRR/005. Strings (Loop=5616,AD=$F4,SR=$E6,Echo)(C9Freq=$F880).brr"