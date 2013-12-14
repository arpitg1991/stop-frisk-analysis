### This is used to scrape the police descriptions on website for our map



# Below function taken from http://www.r-bloggers.com/htmltotext-extracting-text-from-html-via-xpath/
  htmlToText <- function(input, ...) {
    ###---PACKAGES ---###
    require(RCurl)
    require(XML)
    
    
    ###--- LOCAL FUNCTIONS ---###
    # Determine how to grab html for a single input element
    evaluate_input <- function(input) {    
      # if input is a .html file
      if(file.exists(input)) {
        char.vec <- readLines(input, warn = FALSE)
        return(paste(char.vec, collapse = ""))
      }
      
      # if input is html text
      if(grepl("</html>", input, fixed = TRUE)) return(input)
      
      # if input is a URL, probably should use a regex here instead?
      if(!grepl(" ", input)) {
        # downolad SSL certificate in case of https problem
        if(!file.exists("cacert.perm")) download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.perm")
        return(getURL(input, followlocation = TRUE, cainfo = "cacert.perm"))
      }
      
      # return NULL if none of the conditions above apply
      return(NULL)
    }
    
    # convert HTML to plain text
    convert_html_to_text <- function(html) {
      doc <- htmlParse(html, asText = TRUE)
      text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
      return(text)
    }
    
    # format text vector into one character string
    collapse_text <- function(txt) {
      return(paste(txt, collapse = " "))
    }
    
    ###--- MAIN ---###
    # STEP 1: Evaluate input
    html.list <- lapply(input, evaluate_input)
    
    # STEP 2: Extract text from HTML
    text.list <- lapply(html.list, convert_html_to_text)
    
    # STEP 3: Return text
    text.vector <- sapply(text.list, collapse_text)
    return(text.vector)
  }

  result <- htmlToText(url)
  
getDesc <- function(precinctNo){
  precLength <- nchar(precinctNo)
  if (precLength == 1){
    precinctNo <- paste("00",precinctNo, sep = "")
  }
    else if (precLength == 2){
    precinctNo <- paste("0",precinctNo, sep = "")
  }

  baseUrl <- 'http://www.nyc.gov/html/nypd/html/precincts/precinct_' 
  url <- paste(baseUrl, precinctNo,'.shtml',sep='')
  result <- htmlToText(url)
  
  require(stringr)
  profile <- str_locate(result, 'Profile')
  contact <- str_locate(result, "Contact Information")
  desc <- substr(result, profile[2]+1, contact[1]-1)
  desc <- gsub('\\t|\\n|\\r','',desc)  
}  

test <- getDesc("111")  
  
precinctList <- c("1","5","6","7","9","10","13","14","17","18","19","20","22","23","24","25","26","28","30","32","33","34","40","41","42","43","44","45","46","47","48","49","50","52","60","61","62","63","66","67","68","69","70","71","72","73","75","76","77","78","79","81","83","84","88","90","94","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","120","122","123")
  
df <- data.frame(precinctList)  
names(df) = 'Precinct'
  
df$desc <- apply(df,1,FUN = getDesc)
  
write.table(df,file = 'precinctDesc.tsv', sep='\t')