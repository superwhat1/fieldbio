#Open datasets

PL_complete = read.csv("./Lythrum/PL_refined.csv", stringsAsFactors = FALSE)
Lythrum_2017 = read.csv("./Lythrum/Lythrum2017FieldData.csv", stringsAsFactors = FALSE)

# Replace NA with zero, this only affects the stem height, stem count and damage columns
PL_complete$File = NULL
trimws(PL_complete)
trimws(Lythrum_2017)
gsub('NA',NA,PL_complete)
gsub('NA',NA,Lythrum_2017)

# Rename Block column to "BLOCK" in PL_complete dataset so they have have the same column for merging
names(PL_complete)[3] = "BLOCK"

# Add a merging column called BL_ID to each dataset
PL_complete$BL_ID = paste(PL_complete$BLOCK, PL_complete$ID, sep='-')
Lythrum_2017$BL_ID = paste(Lythrum_2017$BLOCK, Lythrum_2017$ID, sep='-')

# Add a PREV column for the previous years plant weight(VEGWT + RWT)
Lythrum_2017$PREV = Lythrum_2017$VEGWT+Lythrum_2017$RWT

#New dataset with NA replaced with zero
PL_0 = PL_complete
PL_0[is.na(PL_0)]=0

PL_match_0 = merge(PL_0, Lythrum_2017, by='BL_ID', all = FALSE)
PL_match_c = merge(PL_complete, Lythrum_2017, by='BL_ID', all = FALSE)

# Merge while keeping missing values
PL_miss_0 = merge(PL_0, Lythrum_2017, by="BL_ID", all=TRUE)
PL_miss_c = merge(PL_complete, Lythrum_2017, by="BL_ID", all=TRUE)

#Extract Muzz and Eugene experiments
Muzz = subset(PL_match_0, SOURCE == 'M')
Eugene = subset(PL_match_0, SOURCE == 'E')


# Write csv to file
write.csv(Muzz,'./Lythrum/Muzz_Data', row.names = FALSE)
write.csv(Eugene, './Lythrum/Eugene_Data', row.names = FALSE)

write.csv(PL_match_0,'./Lythrum/PL_match_0', row.names = FALSE)
write.csv(PL_match_0,'./Lythrum/PL_match_c', row.names = FALSE)
write.csv(PL_match_0,'./Lythrum/PL_miss_0', row.names = FALSE)
write.csv(PL_match_0,'./Lythrum/PL_miss_c', row.names = FALSE)



