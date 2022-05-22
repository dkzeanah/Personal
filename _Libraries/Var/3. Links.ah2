Class C_Links {
   
   ;Social media
   ;————————————————————————————————

   Reddit => "https://www.reddit.com/notifications"
   Instagram => "https://www.instagram.com/"
   Twitter => "https://twitter.com/home"


   ;Special websites
   ;————————————————————————————————

   Eku => "https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . this.lnk_ekursTime()
   Gmail => "https://mail.google.com/mail/u/0/#inbox"
   Mal => "https://myanimelist.net/profile/Axlefublr"
   Metta => "https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4"
   Movies => "https://watchmovieshd.ru/"
   Better_call_saul => "https://watchmovieshd.ru/series/better-call-saul-82zxv/6-3"
   Gogoanime => "https://gogoanime.fi/"

   lnk_ekursTime() {
      ;Time part of the ekursы link
      Switch A_MMMM {
         Case "April":    ekursTime := 1648746000
         Case "May":      ekursTime := 1651338000
         Case "June":     ekursTime := 1654016400
         Case "July":     ekursTime := 1656608400
         Case "August":   ekursTime := 1659286800
         Case "September":ekursTime := 1661965200
         Case "October":  ekursTime := 1664557200
         Case "November": ekursTime := 1667235600
         Case "December": ekursTime := 1669827600
      }
      return ekursTime
   }


   ;Shops
   ;————————————————————————————————
   
   Mvideo => "https://www.mvideo.ru/"
   Zakazaka => "https://zaka-zaka.com/"
   Barber => "https://b73723.yclients.com/company/89170/"
   
   
   ;"databases"
   ;————————————————————————————————

   Weather => "https://yandex.ru/pogoda/krasnoyarsk"
   Emoji => "https://www.alt-codes.net/smiley_alt_codes.php"
   Share_files => "https://files.fm/"
   Regex => "https://regex101.com/"
   Sounds => "https://www.myinstants.com/index/ru/"
   ytdownload => "https://ytb.rip/en/"
   Regex_generator => "https://ibnuhx.com/regex-generator/"

   
   ;docs
   ;————————————————————————————————

   Image_search_tips => "https://github.com/nuj123/AutoHotKey/blob/master/ImageSearchFAQ.md"
   Dll_calls => "https://docs.microsoft.com/en-us/windows/win32/api/"
   Open_asar => "https://openasar.dev/"
   Ahk_wiki => "https://autohotkey.wiki/"


   ;Git file links
   ;————————————————————————————————

   Runner => "https://github.com/Axlefublr/Personal/blob/main/Main/Runner.ah2"


   ;Ahk tutorial videos
   ;————————————————————————————————

   Run_on_reboot => "https://youtu.be/vjQIbagvkcs"
   Arrow => "https://youtu.be/nSTL3KND25c"
   v2_setup => "https://youtu.be/TSvp6ktqo1Q"
   Syntax_highlighting => "https://youtu.be/kYtKBncvEAA"
   Ternary_is_readable => "https://youtu.be/RsH6A2Cuo-c"
   Getters => "https://youtu.be/Nn6ndRMsDJs"


   ;Memes
   ;————————————————————————————————

   I_made_it_the_fuck_up => "https://www.youtube.com/watch?v=r7l0Rq9E8MY"
   Funny_mic => "https://www.youtube.com/watch?v=jfbKJy_ZuIU"
   Delay_lama => "https://www.youtube.com/watch?v=Np4iG7-se7I"
   I_quickly_became_homophobic => "https://www.youtube.com/watch?v=m2ksGuqf8eo"
   If_you_design_a_quest => "https://www.youtube.com/watch?v=chn0ggv9TdY"
   Zoro_is_racist => "https://www.youtube.com/watch?v=kb_udP2ZeF8"
   Loaf_check => "https://www.youtube.com/watch?v=jvds0ib84VA"
   A_shit_of_piece => "https://youtu.be/jsaRzVIBrg8?t=12"
   Are_you_going_to_finish_that_croissant => "https://youtu.be/UZKcSuYaBQY?t=2"
   Arab_cat => "https://www.youtube.com/watch?v=2rYQ1FC1orc"
   Kitten_in_towel => "https://www.youtube.com/watch?v=nRBERbcbFgY"
   Top_ten_cat_loafs => "https://www.youtube.com/watch?v=_kRaKHKCj0g"
   Do_the_skype_thing => "https://www.youtube.com/watch?v=ztubL6yVFkw"
   Keke_gay => "https://www.youtube.com/watch?v=OpOyEUjHS1Q"
   
}
Links := C_Links()