
55000 Rem ************** Ο Π Λ Ι Σ Μ Ο Ι  ΔΟΚΩΝ ΠΛΑΚΩΝ  ΣΕ ΚΑΜΨΗ ****************
Rem  ΑΛΓΟΡΙΘΜΟΙ ΔΙΑΣΤΑΣΙΟΛΟΓΗΣΗΣ KAI ΟΠΛΙΣΜΟΥ ΟΠΛΙΣΜΕΝΟΥ ΣΚΥΡΟΔΕΜΑΤΟΣ ΜΕ ΕΠΙΤΡΕΠΟΜΕΝΕΣ ΤΑΣΕΙΣ
Rem        ΙΩΑΝΝΗΣ ΜΠΟΥΡΔΑΚΗΣ (BOURDAKIS IOANNIS),(BOURDAKIS YANNIS) ΠΟΛΙΤΙΚΟΣ ΜΗΧΑΝΙΚΟΣ ΕΜΠ 1975
55010 Rem *********ΡΟΥΤΙΝΑ ΣΤΑΔΙΟ ΙΙ ΔΕΔΟΜΕΝΑ ME N d b SBEP SEEP ΑΠΟ ΣΤΑΤΙΚΗ ΕΦΑΡΜΟΓΗ ********
Rem ΔΕΔΟΜΕΝΑ ΡΟΥΤΙΝΑΣ *******   Ροπή [ΜE] tm  [H] cm στατικο υψος  [BY] cm πλατος δοκου στηριξη η πλακοδοκου ανοιγμα SEEP Kp/cm^2 SBEP Kp/cm^2    ********
Rem *********ΠΡΟΣΟΧΗ εδω δινουμε το Η στατικο υψος αντι του  D συνολικο υψος λογω διαφορετικου a μεταξυ πλακων η δοκων *****************
Rem******* ιδια ρουτινα και για πλακες ********
Rem ********ME για τη ροπη  αντι του Μ που ειναι το ζητούμενο στη ρουτινα ο λὸγος σe/σb δείτε και το ΣΚΥΡΟΔΕΜΑ ΟΠΛΙΣΜΟΣ ΔΙΑΤΟΜΩΝ.pdf  *****************************

If ME < .1 Or H < 8 Or BY < 20 Or SBEP < 60 Or SEEP < 1400 Then Cls: Print "ME ="; ME: Print "H ="; H: Print "B ="; BY: Print "SBEP="; SBEP: Print "SEEP="; SEEP: Print "Μή αποδεκτή τιμή": GoSub 55890: Return

55020 Rem *************** OΠΛΙΣMOΣ ************
55040 SE = SEEP: SB = 0: FE = 0: FEA = 0
55060
55080 Locate 7, 31: Print "B="; BY;: Print "H="; H
55100 Locate 9, 20: Print "Απλός Οπλισμός"
55120
55140 Rem
55160 Rem ******** AΠΛΟΥΣ OΠΛIΣMOΣ *********
55180 ST2 = .1: ST1 = 600: M1 = 0: ME = 10 ^ 5 * ME: B = BY: SE = SEEP: SB = 0
55200 For M = ST1 To M1 Step -ST2

    55220 HH1 = (15 + M) * Sqr(6 * M * ME) / Sqr(15 * B * SE * (2 * 15 + 3 * M))
    55240 If Abs(HH1 - H) > .1 Then 55250 Else GoTo 55260

55250 Next M

55260 Rem
55280 Rem
55300 HH1 = (15 + M) * Sqr(6 * M * ME) / Sqr(15 * B * SE * (2 * 15 + 3 * M)): XX1 = 15 * H / (M + 15)
Locate 12, 13: Print "M ="; Using " ###.## "; ME / 10 ^ 5;: Print " m ="; Using "###.## "; M
Locate 13, 13: Print "h ="; Using "  ##.## "; HH1;: Print " x ="; Using " ##.## "; XX1
55320 FE = 3 * ME / (SEEP * (3 * H - XX1)): Locate 14, 13: Print "FE="; Using "  ##.##   "; FE
55340 SB = SE / M
55360 Locate 15, 13: Print "σe="; Using "####.##  "; SEEP;: Print "σb="; Using "###.##  "; SB
55380 If SB > SBEP Then Beep: GoTo 55440
GoSub 55890
55400 Cls: Return

55420 Rem
55440 Rem *********** ΔΙΠΛΟΣ ΟΠΛΙΣΜΟΣ *********
55460 Locate 9, 20: Print "Διπλός Οπλισμός"
55480 SE = SEEP: SB = SBEP
55500 X = 15 * H * SBEP / (15 * SBEP + SE)
55520 SEA1 = 15 * SBEP * (X - A) / X
55540 DB = .5 * X * B * SBEP
55560 FEA = (ME - DB * (H - X / 3)) / (SEA1 * (H - A))
55580 FE = (DB + FEA * SEA1) / SE

55600 Locate 12, 13: Print "M ="; Using " ###.## "; ME / 10 ^ 5;: Print " x ="; Using "  ##.## "; X
55620 Locate 13, 13: Print "σb="; Using " ###.## "; SB;: Print "                       "
55640 Locate 14, 13: Print "σe="; Using "####.## "; SE;: Print "σe'="; Using "####.## "; SEA1
55660 Locate 15, 13: Print "FE="; Using "  ##.## "; FE;: Print "FE'="; Using "  ##.## "; FEA
GoSub 55890
55700 Cls: Return

55890 Rem * * * * * S P A C E   B  A  R
56000 Locate 24, 16, 0, 0, 14: Color 14, 1: Print "   Μ Π Α Ρ Α   Γ Ι Α   Σ Υ Ν Ε X Ε Ι Α   ";
Locate 25, 17, 0, 0, 14: Color 0, 2: Print "                                         ";: Color 7, 0
56010 Z$ = InKey$: If Z$ = "" Then 56010
Return

