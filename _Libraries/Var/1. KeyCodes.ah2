D_KeyCodes_In := Map(
"~",                        "SC029", 
"1",                        "SC002", 
"2",                        "SC003", 
"3",                        "SC004", 
"4",                        "SC005", 
"5",                        "SC006", 
"6",                        "SC007", 
"7",                        "SC008", 
"8",                        "SC009", 
"9",                        "SC00A", 
"0",                        "SC00B", 
"-",                        "SC00C", 
"=",                        "SC00D", 
"q",                        "SC010", 
"w",                        "SC011", 
"e",                        "SC012", 
"r",                        "SC013", 
"t",                        "SC014", 
"y",                        "SC015", 
"u",                        "SC016", 
"i",                        "SC017", 
"o",                        "SC018", 
"p",                        "SC019", 
"[",                        "SC01A", 
"]",                        "SC01B", 
"\",                        "SC02B", 
"a",                        "SC01E", 
"s",                        "SC01F", 
"d",                        "SC020", 
"f",                        "SC021", 
"g",                        "SC022", 
"h",                        "SC023", 
"j",                        "SC024", 
"k",                        "SC025", 
"l",                        "SC026", 
";",                        "SC027", 
"'",                        "SC028", 
"z",                        "SC02C", 
"x",                        "SC02D", 
"c",                        "SC02E", 
"v",                        "SC02F", 
"b",                        "SC030", 
"n",                        "SC031", 
"m",                        "SC032", 
"<",                        "SC033", 
">",                        "SC034", 
"/",                        "SC035", 
"F1",                       "SC03B", 
"F2",                       "SC03C", 
"F3",                       "SC03D", 
"F4",                       "SC03E", 
"F5",                       "SC03F", 
"F6",                       "SC040", 
"F7",                       "SC041", 
"F8",                       "SC042", 
"F9",                       "SC043", 
"F10",                      "SC044", 
"F11",                      "SC057", 
"F12",                      "SC058", 
"Capslock",                 "SC03A", 
"Backspace",                "SC00E", 
"Enter",                    "SC01C", 
"Tab",                      "SC00F", 
"Printscreen",              "SC137", 
"Delete",                   "SC153", 
"Escape",                   "SC001", 
"CtrlBreak",                "SC146",
"Pause",                    "SC045",
"ScrollLock",               "SC046",
"Insert",                   "SC152",
"AppsKey",                  "SC15D", 
"LShift",                   "SC02A", 
"RShift",                   "SC136", 
"LCtrl",                    "SC01D", 
"LWin",                     "SC15B", 
"LAlt",                     "SC038", 
"RAlt",                     "SC138", 
"RCtrl",                    "SC11D", 
"num*",                     "SC037", 
"num/",                     "SC135", 
"num+",                     "SC04E", 
"num-",                     "SC04A", 
"num.",                     "SC053", 
"num1",                     "SC04F",
"num2",                     "SC050",
"num3",                     "SC051",
"num4",                     "SC04B",
"num5",                     "SC04C",
"num6",                     "SC04D",
"num7",                     "SC047",
"num8",                     "SC048",
"num9",                     "SC049",
"Volume_Down",              "SC12E",
"pleading",                 "U+1F97A", 
"yum",                      "U+1F60B", 
"exploding_head",           "U+1F92F", 
"smirk_cat",                "U+1F63C", 
"sunglasses",               "U+1F60E", 
"sob",                      "U+1F62D", 
"face_with_monocle",        "U+1F9D0", 
"flushed",                  "U+1F633", 
"face_with_raised_eyebrow", "U+1F928", 
"purple_heart",             "U+1F49C", 
"skull",                    "U+1F480", 
"rolling_eyes",             "U+1F644", 
"thinking",                 "U+1F914", 
"weary",                    "U+1F629", 
"woozy",                    "U+1F974",
"finger_left",              "U+1F448",
"finger_right",             "U+1F449",
"drooling",                 "U+1F924",
"eggplant",                 "U+1F346",
"smiling_imp",              "U+1F608",
"long_dash",                "{ASC 0151}",
"middle_dot",               "{U+00B7}"
)

D_KeyCodes_Out := Map()
for key, value in D_KeyCodes_In ;Copy of the dictionary with reversed keys and values
   D_KeyCodes_Out[value] := key

