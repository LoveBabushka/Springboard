library(dplyr)
library(tidyr)

refine_original <- read.table("refine.csv", header=TRUE, sep=",")
str(refine_original)
View(refine_original)
refine_clean <- tbl_df(refine_original)



##part1
#recode misspelled words in the variable "company"


refine_clean$company <- tolower(refine_clean$company)


refine_clean$company <-  gsub ("phillips|phllips|phillps|fillips|phlips", "philips", refine_clean$company) 
refine_clean$company <-  gsub ("akz0|ak zo", "akzo", refine_clean$company) 
refine_clean$company <-  gsub ("unilver", "unilever", refine_clean$company)
View(refine_clean)



##part 2
##separate Product.code...number into two separate variabes - prodcut_code and product_number
refine_clean <-separate(refine_clean, Product.code...number, c("product_code", "product_number"), sep ="-")
View(refine_clean)

#part3
#add a new variable called product_category that represent the product_code

refine_clean$product_category[refine_clean$product_code == "p"] <- "Smartphone"
refine_clean$product_category[refine_clean$product_code == "v"] <- "TV"
refine_clean$product_category[refine_clean$product_code == "x"] <- "Laptop"
refine_clean$product_category[refine_clean$product_code == "q"] <- "Tablet"
View(refine_clean)


## part 4
#reate a new column full_address that concatenates the three address fields (address, city, country), separated by commas
refine_clean <- unite (refine_clean, "full_address", address, city, country, sep = ",")
View(refine_clean)

## part 5
#Create dummy variables for company and product category
##binary varibales for company
refine_clean$company_phillips<-ifelse(refine_clean$company=="philips",1,0)
refine_clean$company_akzo<-ifelse(refine_clean$company=="akzo",1,0)
refine_clean$company_van_houten<-ifelse(refine_clean$company=="van houten",1,0)
refine_clean$company_unilever<-ifelse(refine_clean$company=="unilever",1,0)  
View(refine_clean)


#part6
##save my new dataset 
write.csv(refine_clean, file = "refine_clean.csv")

