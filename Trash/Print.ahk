v1_F_Print(p*) {
    static _ := DllCall("AllocConsole"), cout := FileOpen("CONOUT$", "w")
    for k, v in p
        out .= "`t" (IsObject(v) ? v1_F_Print_Dump(v) : v)
    cout.Write(SubStr(out, 2) "`n")
    cout.__Handle ; Flush write buffer
}

v1_F_Print_Dump(obj, quote:=False, end:="") {
    static escapes := [["``", "``" "``"], ["""", """"""], ["`b", "``b"]
    , ["`f", "``f"], ["`r", "``r"], ["`n", "``n"], ["`t", "``t"]]
    if IsObject(obj) {
        for k in obj
            is_array := k == A_Index
        until !is_array
        out .= is_array ? "[" : "{"
        for k, v in obj {
            out .= (A_Index > 1 ? ", " : "")
            . (is_array ? _ : %A_ThisFunc%(k, 1, "") ": ")
            . %A_ThisFunc%(v, 1, "")
        }
        return out . (is_array ? "]" : "}") end
    }
    if (!quote || ObjGetCapacity([obj], 1) == "")
        return out . obj . end
    for k, v in escapes
        obj := StrReplace(obj, v[1], v[2])
    while RegExMatch(obj, "O)[^\x20-\x7e]", m)
        obj := StrReplace(obj, m[0], Format(""" Chr({:04d}) """, Ord(m[0])))
    return out """" obj """" end
}