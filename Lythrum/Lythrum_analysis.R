#Open datasets
PL_complete = read.csv("./Lythrum/PL_refined.csv", stringsAsFactors = FALSE)
Lythrum_2017 = read.csv("./Lythrum/Lythrum2017FieldData.csv", stringsAsFactors = FALSE)

# Replace NA with zero, this only affects the stem height, stem count and damage columns
PL_complete$File = NULL
trimws(PL_complete)
trimws(Lythrum_2017)
gsub('NA',NA,PL_complete)
gsub('NA',NA,Lythrum_2017)

sum(is.na(PL_complete))
sum(is.na(Lythrum_2017)) 

# Rename Block column to "BLOCK" in PL_complete dataset so they have have the same column for merging
names(PL_complete)[3] = "BLOCK"
names(PL_complete)

#New dataset with NA replaced with zero
PL_0 = PL_complete
PL_0[is.na(PL_0)]=0
# Enter proper Latitude for plants from Srouce M
###
gsub(0,44.29771,Lythrum_2017['LAT'])
gsub(NA,44.29771,Lythrum_2017['LAT'])
gsub('NA',44.29771,Lythrum_2017['LAT'])
###

# Add a merging column called BL_ID to each dataset
PL_0$BL_ID = paste(PL_0$BLOCK, PL_0$ID, sep='-')
Lythrum_2017$BL_ID = paste(Lythrum_2017$BLOCK, Lythrum_2017$ID, sep='-')

# Merge datasets with merge() function

PL_merged_w_match = merge(PL_0, Lythrum_2017, by='BL_ID', all = FALSE)
View(PL_merged_w_match)

str(PL_merged_w_match)
str(PL_0)


# Notice the number of observations in the 'Environment' tab shows that some rows are missing

#Check for duplicated rows
PL_0[duplicated(PL_0$BL_ID),]
sum(duplicated(PL_0$BL_ID))

sum(duplicated(Lythrum_2017$BL_ID))

# No duplicates in either dataset
# Check for unique values
BL_ID = c(PL_0$BL_ID,Lythrum_2017$BL_ID)
# Sort BL_ID using the order() function
BL_ID = BL_ID[order(BL_ID)]
uniq= BL_ID [!duplicated(BL_ID)]
sum(!duplicated(BL_ID))

# Merge while keeping missing values
Merged_w_missing = merge(PL_0, Lythrum_2017, by="BL_ID", all=TRUE)

# Check for missing data using BLOCK.y and BLOCK.x
Merged_w_missing[is.na(Merged_w_missing$BLOCK.x),]
Merged_w_missing[is.na(Merged_w_missing$BLOCK.y),]

# Add value to Source column for those that dont have one in the Lythrum_2017 dataset
#for x in Merged_w_missing[SOURCE]:
 # if is.na(x):
  #  x = Merged_w_missing[1,x]

# Write csv to file
Muzz = subset(Merged_w_missing, SOURCE == 'M')
Eugene = subset(Merged_w_missing, SOURCE == 'E')
PL_merged_w_match
write.csv(Muzz,'./Lythrum/Muzz_Data', row.names = FALSE)
write.csv(Eugene,'./Lythrum/Eugene_Data',row.names = FALSE)
write.csv(PL_merged_w_match,'./Lythrum/PL_merged_w_match',row.names = FALSE)













