# Using the google scholar package
assign(".lib.loc", "c:/Giles/R/Libraries", envir = environment(.libPaths))
#install.packages("scholar",type='source',dependencies= TRUE,lib='c:/Giles/R/Libraries')

library(tidyverse,lib='c:/Giles/R/Libraries')
library(scholar,lib='c:/Giles/R/Libraries')


# Roy's Google Scholar id
# from https://scholar.google.co.uk/citations?user=z6jaMRcAAAAJ&hl=en

mep_data <- read_csv("c:/Giles/Group stuff/Website/google_scholar_MEP.csv",
                    na=c("(null)", "N/A","NA"))


scholar_ids<- mep_data$Scholar_ID

all_pubs<-NULL

for(ss in scholar_ids) {
  get_publications(ss) %>%
    rbind(all_pubs)  -> all_pubs   
}

all_pubs %>% 
  
  mutate(All_info=paste(year,title,author,journal,number,sep = ", "),
         Title_lower=tolower(title)) %>% 
  arrange(desc(All_info)) %>% 
  distinct(pubid, .keep_all = TRUE) %>% 
  distinct(Title_lower, .keep_all = TRUE) %>% 
  filter(year!="1977") %>% #odd one for Roy  
  dplyr::select(All_info)->all_pubs_trim  


write_tsv(all_pubs_trim,"C:/Giles/Group stuff/Website/MEP_publications.txt")
#write_csv((paste("C:/Giles/Group stuff/Website/Publications - Dist", ,".csv")))






