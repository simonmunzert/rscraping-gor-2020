### -----------------------------
## simon munzert
## regular expressions and
## string manipulation
### -----------------------------


source("packages.r")


## string matching ----------

# example
raw.data <- "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555-6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson, Homer5553642Dr. Julius Hibbert"

name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name

phone <- unlist(str_extract_all(raw.data, "\\(?(\\d{3})?\\)?(-| )?\\d{3}(-| )?\\d{4}"))
phone
data.frame(name = name, phone = phone)

# running example
example.obj <- "1. A small sentence. - 2. Another tiny sentence."

# self match
str_extract(example.obj, "small")
str_extract(example.obj, "banana")
str_extract(example.obj, "e")
str_extract_all(example.obj, "e")

# multiple matches
(out <- str_extract_all(c("text", "manipulation", "basics"), "a")) 

# match the beginning of a string
str_extract(example.obj, "^1")
str_extract(example.obj, "^2")

# match the end of a string
str_extract(example.obj, "sentence$")
str_extract(example.obj, "sentence.$")

# wildcard
str_extract(example.obj, "sm.ll")

# character class
str_extract(example.obj, "sm[abc]ll")

# character class: range
str_extract(example.obj, "sm[a-p]ll")

# character class: additional characters
unlist(str_extract_all(example.obj, "[uvw. ]"))

# pre-defined character classes
unlist(str_extract_all(example.obj, "[:punct:]"))
unlist(str_extract_all(example.obj, "[[:punct:]ABC]"))
unlist(str_extract_all(example.obj, "[^[:alnum:]]"))
# for more character classes, see
?base::regex

# quantifier
str_extract(example.obj, "s[:alpha:][:alpha:][:alpha:]l")
str_extract(example.obj, "s[:alpha:]{3}l")
str_extract(example.obj, "s[:alpha:]{1,}l")
str_extract(example.obj, "A.+sentence")

# greedy quantification
str_extract(example.obj, "A.+sentence")
str_extract_all(example.obj, "A.+?sentence")

# meta characters
unlist(str_extract_all(example.obj, "\\."))
unlist(str_extract_all(example.obj, fixed(".")))

# do you think you can master regular expressions now?
browseURL("http://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address/201378#201378") # think again




## string manipulation ----------

example.obj

# locate
str_locate(example.obj, "tiny")

# substring extraction
str_sub(example.obj, start = 35, end = 38)

# replacement
str_sub(example.obj, 35, 38) <- "huge"
str_replace(example.obj, pattern = "huge", replacement = "giant")

# splitting
str_split(example.obj, "-") %>% unlist
str_split_fixed(example.obj, "[:blank:]", 5) %>% as.character()

# manipulate multiple elements; example
(char.vec <- c("this", "and this", "and that"))

# detection
str_detect(char.vec, "this")

# keep strings matching a pattern
str_subset(char.vec, "this") # wrapper around x[str_detect(x, pattern)]

# counting
str_count(char.vec, "a")
str_count(char.vec, "\\w+")
str_length(char.vec)



## EXERCISES ----------

## 1. describe the types of strings that conform to the following regular expressions and construct an example that is matched by the regular expression.
str_extract_all("???", "[0-9]+\\$")
str_extract_all("???", "\\d{2}/\\d{2}/\\d{2,4}")

## 2. consider the mail address  chunkylover53[at]aol[dot]com. Now, transform the string to a standard mail format using regular expressions.

email <- "chunkylover53[at]aol[dot]com"





