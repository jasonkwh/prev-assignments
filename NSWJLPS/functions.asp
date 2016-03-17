<%

Dim temp, key

key = "huasHIYhkasdho1" 

Function encrypt(Str)
 Dim lenKey, KeyPos, LenStr, x, Newstr
 
 Newstr = ""
 lenKey = Len(key)
 KeyPos = 1
 LenStr = Len(Str)
 str = StrReverse(str)
 For x = 1 To LenStr
      Newstr = Newstr & chr(asc(Mid(str,x,1)) + Asc(Mid(key,KeyPos,1)))
      KeyPos = keypos+1
      If KeyPos > lenKey Then KeyPos = 1
 Next
 encrypt = Newstr
End Function

Function Decrypt(str)
 Dim lenKey, KeyPos, LenStr, x, Newstr
 
 Newstr = ""
 lenKey = Len(key)
 KeyPos = 1
 LenStr = Len(Str)
 
 str=StrReverse(str)
 For x = LenStr To 1 Step -1
      Newstr = Newstr & chr(asc(Mid(str,x,1)) - Asc(Mid(key,KeyPos,1)))
      KeyPos = KeyPos+1
      If KeyPos > lenKey Then KeyPos = 1
      Next
      Newstr=StrReverse(Newstr)
      Decrypt = Newstr
End Function


Function RandomString( )

    Randomize( )

    Dim CharacterSetArray
    CharacterSetArray = Array( _
      Array( 7, "abcdefghijklmnopqrstuvwxyz" ), _
      Array( 1, "0123456789" ) _
    )

    Dim i
    Dim j
    Dim Count
    Dim Chars
    Dim Index
    Dim Temp

    For i = 0 To UBound( CharacterSetArray )

      Count = CharacterSetArray( i )( 0 )
      Chars = CharacterSetArray( i )( 1 )

      For j = 1 To Count

        Index = Int( Rnd( ) * Len( Chars ) ) + 1
        Temp = Temp & Mid( Chars, Index, 1 )

      Next

    Next

    Dim TempCopy

    Do until Len( Temp ) = 0

      Index = Int( Rnd( ) * Len( Temp ) ) + 1
      TempCopy = TempCopy & Mid( Temp, Index, 1 )
      Temp = Mid( Temp, 1, Index - 1 ) & Mid( Temp, Index + 1 )

    Loop

    RandomString = TempCopy

  End function

%>

