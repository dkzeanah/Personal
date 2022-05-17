# Colors I use

**#bf7465** — hotkey brown

**#ceac7b** — mild yellow

**#CF68E1** — keyword purple

**#A78CFA** — static purple

**#dc5579** — bold pink

**#d89aec** — gay pink

**#56B7C3** — classy cyan

**#98C379** — string green

**#676E95** — comment grey

**#B0B7C3** — vary white

**#6495EE** — function blue

**#FF9070** — digit orange

# Links to the other files in the tutorial

[coloring book :)](https://github.com/Axlefublr/Other/blob/main/Libraries%20v2/Ahk%20code%20coloring/coloring%20book.ah2)

[tmLanguage](https://github.com/Axlefublr/Other/blob/main/Libraries%20v2/Ahk%20code%20coloring/tmLanguage.json)

[color settings preset for settings.json](https://github.com/Axlefublr/Other/blob/main/Libraries%20v2/Ahk%20code%20coloring/color%20settings%20preset.txt)

# Regex and code classes — documentation

Explanation of every regex in the "ahk.tmLanguage.json" file, in the same order. 

Some keyword classes may repeat, so when searching through, keep in mind what regex you're actually searching for. 

This file or extension is not mine at all, all I did was edit it, so most of the appreciation should go to the creator of the extension.

There's a "strength" system, meaning the higher a code class is, the more overruling it will be. 

This is why everything after ; will still be colored grey even if you have something like this() in it, this() won't be highighted as a function because comments are stronger

---

---
### **comment.ahk** — ; comment

everything after `;`

```
\\s*(;.*)
```

---
### **comment.ahk** — block comment

begins capturing everything after `/*` *(at the start of the line)*

```
^\\s*/\\*
```

stops the capture at next `*/` *(also at the start of the line)*

```
^\\s*\\*/
```

---
### **string.continuation.ahk** — continuation section

Begins capturing if a `(` is at the start of the line and is followed by a newline. 

Won't capture if the `(` is followed by anything other than any number of spaces, tabs or a newline *(i.e. — won't capture `(word` )*

```
^\\s*\\([ \\t]*\\n
```

Stops the capture at the next `)` that starts on a new line *(no matter how many spaces are before it)*

```
^\\s*\\)
```

---

### **support.class.ahk** — class self call

Catches any word that starts with `C_` *(case insensitive)* and ends with `(` 

Usage: calling a class into an object so the call looks like the coloring for the class name

```
\\b(?i:C_\\w+)\\(
```

Example: 
```
Class := C_Class()
```

---

### **support.class.builtin.property.ahk** — built in class properties

Matches all the built-in properties if they go after a `.`

```
\\b(?<=\\.)(?i:__item|marginx|..........|maxparams)\\b
```

---

### **support.class.builtin.method.ahk** — built in class methods

Matches all the built-in methods if they go after a `.` and are preceeded by a `(`

```
\\b(?<=\\.)(?i:insertat|removeat|.........|isoptional)(?=\\()\\b
```

---

### **support.class.ahk** — class part of a method / property call

Catches any word that is followed by a `.property` or `.%property%` or `.method()` or `.%method%()`

```
\\w+(?=\\.[%]?\\w+[%]?[( ])
```

---

### **hotkey.label.definition.ahk** — hotstring colons

in `:X0?:btw::by the way` would catch `:X0?:` and `::`

```
(?i: *((:[bceiknoprsxz0?\\*]{0,4}:).+(::))([^;]*))
```

---

### **hotkey.label.hotkey.ahk** — hotstring's activation trigger

in `:X0?:btw::by the way` would catch `btw`

```
(?i: *((:[bceiknoprsxz0?\\*]{0,4}:).+(::))([^;]*))
```

---

### **hotkey.label.hotkey.ahk** — hotkey name (activation trigger)

in `!+Pause::` catches `!+Pause`

```
^\\s*(.+)(::)
```

---

### **hotkey.label.definition.ahk** — hotkey colons

in `!+Pause::` catches `::`

```
^\\s*(.+)(::)
```

---

### **directives.parameters.ahk** 

in `#InputLevel 5 ;this sets the inputlevel` catches `5`

```
#\\b\\w*(?!:{1,2})\\b([^;]*)(\\s+;.*)?$
```

---

### **keyword.control.directives.ahk**

in `#InputLevel 5 ;this sets the inputlevel` catches `#InputLevel`

```
#\\b\\w*(?!:{1,2})\\b([^;]*)(\\s+;.*)?$
```

---

### **comment.ahk** — comment part of a directive

in `#InputLevel 5 ;this sets the inputlevel` catches `;this sets the inputlevel`

```
#\\b\\w*(?!:{1,2})\\b([^;]*)(\\s+;.*)?$
```

---

### **variable.builtin.ahk** — built-in variables *(A_Clipboard)*

Matches every word that starts with `a_` *(case insensitive)*

```
\\b(?i:a_\\w+)\\b
```

--- 

### **keyword.control.ahk** — class and extends keywords

In `class className1 extends className2` catches `class` and `extends`

```
(?i:\\b(class)\\b\\s*(\\w+))\\s*((extends)\\s+(\\w+))?
```

---

### **support.class.ahk** — class definitions

In `class className1 extends className2` catches `className1`, `className2`

```
(?i:\\b(class)\\b\\s*(\\w+))\\s*((extends)\\s+(\\w+))?
```

---

### **keyword.control.ahk** — basic keywords like `if`, `else`, `loop` and the like

```
\\b(?i:if|else|switch|case|return|loop|break|for|in|while|catch|finally|throw|try|until|continue|true|false)\\b
```

---

### **constant.numeric.ahk** — numbers

Works well so I'm not even going to try to understand this regex

```
(?x) \\b\r\n((0(x|X)[0-9a-fA-F]*)\r\n|(\r\n  ([0-9]+\\.?[0-9]*)\r\n  |(\\.[0-9]+)\r\n )((e|E)(\\+|-)?[0-9]+)?\r\n)\\b\r\n
```

---

### **keyword.operator.assignment.ahk** — := type assignment

Catches any of the symbols in `[]` if they are followed by a `=` immidiately

```
[\\/|:*+-.~\\^]\\/?=
```

---

### **keyword.operator.arithmetic.ahk** — arithmetic symbols

`\` is an escape symbol in regex and `\` is an escape symbol in json, so you gotta use two to escape special regex characters. Meaning, ignore them

```
[/+\\-*\\^#]
```

---

### **keyword.operator.comparison.ahk** — logical comparisons

Catches any of the characters in the first `[]`, any of the characters in the second `[]` followed by a `=`, the keywords `or`, `and`, `not`, `&&`

```
[<>=!|]|[<>=]=|!(=*)|(?i:or|and|not)|&&
```

---

### **keyword.operator.varref.ahk** — essentially, "other" symbols

`[]` mean "any single character here will be matched", `|` means or

```
=>|[%?&:]
```

---

### **punctuation.ahk** 

```
[`.,]
```

---

### **punctuation.bracket.ahk**

```
[\\[\\](){}]
```

---

### **support.function.builtin.ahk** — built-in functions

Catches all of the built in functions, even without brackets. But only if not preceeded by a `.`

```
(?<!\\.)|send(text|input|play|event|level|message|mode)?|...
```

--- 

### **support.function.ahk** — any function

Catches a word with `(` after it

```
\\b[\\w]+(?=\\()
```

--- 

### **link.string.ahk** — a link in a string

Catches a link in quotes if it starts with either http or https and has no whitespace inside it

```
\"http(s)?:\\/\\/\\S+\"
```

---

### **string.ahk** — string

Catches everything inside of "" that itself isn't inside of "", meaning "yes" ""no""

##### **string.start.ahk**

```
(\")
```

##### **string.end.ahk**

```
(\")
```

##### **punctuation.ahk** — an escaped "

```
`\"
```

---

### **keyword.other.ahk** 

Keywords that aren't built in, but are often used as variable names and the like

So, stuff like winTitle, key, value, index, and so on

Won't be caught if preceeded by a comma

To add yours, put in inside of `||`, like this: `|yourNewKeyword|`

```
\\b(?<!\\.)(?i:k(ey)?|v(alue)?|i(ndex)?|text|(\\w+)title|(\\w+)path|(loc(\\d?)[XY]))\\b
```

---

### **variable.def.ahk**

Any word :)

```
\\w+
```

